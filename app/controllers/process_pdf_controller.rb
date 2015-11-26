class ProcessPdfController < ApplicationController
	
	require 'fileutils'
    require 'tempfile'




	before_action :authenticate_user!

	before_filter :authorize_admin, only: :index

  	def authorize_admin
    	redirect_to :back, :status => 401 unless current_user.admin
    #redirects to previous page
  	end

	def index

		id = params[:id]
		lote = Allotment.find_by_token("#{id}")

		@lote = Allotment.find_by_token "#{params["id"]}"
		@pdf_files = PdfFile.where("allotments_id = ?", @lote.id)

	end

	def create

		token = params["id"]

		lote = Allotment.find_by_token("#{token}")

		consumer = Consumer.find_by_id(lote.consumers_id)

		pdfs = PdfFile.where("allotments_id = ?", lote.id)

		pdfs.each do |pdf|
			
			_pdf_file = Rails.root.join('app', 'resources', "#{pdf.pdf_file.id}.pdf")

			File.open(_pdf_file, 'wb') do |f|
				f.write pdf.pdf_file.read
			end

			extract_file = Rails.root.join('app', 'resources', "#{pdf.pdf_file.id}.txt")

			reader = PDF::Reader.new(_pdf_file)

			has_principal_key = false

			File.open(extract_file, 'w') do |f|
				
				reader.pages.each do |page|
					p = page.text
					if p.include? "Veja aqui o que está sendo cobrado"
						has_principal_key = true
					end
					p = p.gsub("Detalhamento de liga", "\nDetalhamento de liga").gsub("VEJA O USO DETALHADO DO VIVO", "\nVEJA O USO DETALHADO DO VIVO")
					f.write(p)
				end

			end

			if !has_principal_key

				t_file = Tempfile.new('filename_temp.txt')
				
				File.open(extract_file).each_line do |line|
					
					entrou_inicio = false
					entrou_fim = false

					content_line = line

					if line.include? "AEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEB"
						
						line = "#{line}\nVeja aqui o que está sendo cobrado"
						
					end

					t_file.puts line

				end

				t_file.close
    			FileUtils.mv(t_file.path, extract_file)
			end

			#claro
			if pdf.company_id == 1
				count = 0

				ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").destroy_all

				f = File.open(extract_file, "r")
				
				f.each_line do |line|

					count = count + 1
					e = ClaroExtract.new
					e.line = count
					e.content = line
					e.allotment_id = lote.id
					e.id_file = pdf.pdf_file.id
					e.save!

				end
				f.close
	        	### segunda fase
	        	HeaderManagerClaro.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").destroy_all

	        	query = "Veja aqui o que está sendo cobrado"
	        	inicio = ClaroExtract.where("content LIKE ? AND allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'", "%#{query}%").order("line ASC").first
	        	init_line = inicio.line
	        	count = 0
	        	final_line = 0

	        	while true

	        		count = count + 1
	        		next_line = init_line + count

	        		begin
	        			content = ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' and line = #{next_line}").first.content	
	        		rescue Exception => e

	        		end

	        		
	        		if content.match("Total a Pagar") and !content.include? "00000000000-0"
	        			final_line = next_line
	        			break
	        		end
	        	end


	        	e = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'").order("line ASC")
	        	e = e.where(line: init_line..final_line)
	        	query_individual = "Individuais"
	        	query_compartilhados = "Compartilhados"
	        	items_para_quebra = e.where("content LIKE ? OR content LIKE ?", "%#{query_individual}%", "%#{query_compartilhados}%").order("line ASC")

	        	lines_quebra    = []
	        	tmp_quebra      = []
	        	root_contents   = []

	        	items_para_quebra.each do |item| 
	        		lines_quebra << item.line
	        		root_contents << item.content
	        		tmp_quebra << item.line
	        	end

	        	lines_quebra.to_enum.with_index(1).each do |linha_valida, i|
	        		####
	        		tmp_quebra.shift
	        		count = 0

	        		while true
	        			count = count + 1

	        			if tmp_quebra.count == 0
	        				if count + linha_valida == final_line
	        					break
	        				else
	        					e = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'")
	        					e = e.find_by_line(count + linha_valida)

	        					if e.content.split.count > 0

	        						if e.content.match("Total do Mês")
	        							break
	        						else

	        							tipo = ""

	        							if root_contents[i-1].match("Individuais")
	        								tipo = "Individual"
	        							else
	        								tipo = "Compartilhados"
	        							end

	        							item = e.content.split('R$')[0].strip

	        							begin
	        								e.content.split('R$')[1].strip.to_f
	        							rescue Exception => error
		                                    #binding.pry
		                                end

		                                begin

		                                	value = e.content.split('R$')[1].strip.gsub(".", "").gsub(",", ".").to_f

		                                	c = HeaderManagerClaro.new
		                                	c.tipo = tipo
		                                	c.item = item
		                                	c.value = value
		                                	c.allotment_id = lote.id
		                                	c.id_file = pdf.pdf_file.id

		                                	c.save!

		                                rescue Exception => error
		                                    #binding.pry
		                                end

		                                #binding.pry
		                            end
		                        end
		                    end
		                else
		                	if count + linha_valida == final_line or count + linha_valida == tmp_quebra.first
		                		break
		                	else
		                		e = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'")
		                		e = e.find_by_line(count + linha_valida)

		                		if e.content.match("Prezado Cliente")
		                            #binding.pry
		                            break
		                        end

		                        if e.content.split.count > 0

		                        	tipo = ""

		                        	if root_contents[i-1].match("Individuais")
		                        		tipo = "Individual"
		                        	else
		                        		tipo = "Compartilhados"
		                        	end

		                        	begin
		                        		e.content.split('R$')[1].strip.to_f
		                        	rescue Exception => error
		                        		#binding.pry
		                        	end

		                        	begin
		                        		item = e.content.split('R$')[0].strip
		                        		value = e.content.split('R$')[1].strip.gsub(".", "").gsub(",", ".").to_f

		                        		c = HeaderManagerClaro.new
		                        		c.tipo = tipo
		                        		c.item = item
		                        		c.value = value
		                        		c.allotment_id = lote.id
		                        		c.id_file = pdf.pdf_file.id
		                        		c.save!
		                        	rescue Exception => e
		                        		
		                        	end

		                        	

		                        	#binding.pry

		                        end

		                    end
		                end
		            end
	        		####
	        	end

	        	#terceira faze
	        	ClaroTransactionByLine.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").destroy_all
	        	
	        	query = "Detalhamento de ligações e serviços do celular"
	        	detalhamentos = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'")
	        	detalhamentos = detalhamentos.where("content LIKE ?", "%#{query}%").order("id ASC")
	        	proxima_linha = 0


	        	detalhamentos_ids = []

	        	detalhamentos.each do |detalhamento|
	        		detalhamentos_ids << detalhamento.line
	        	end

	        	sub_total_consumo_utilizado_hash    = {}
	        	sub_total_hash_interurbano          = {}
	        	sub_total_hash_dados                = {}
	        	sub_total_hash_dados_m2m_1            = {}
	        	sub_total_hash_dados_m2m_2            = {}

	        	detalhamentos.each do |detalhamento|
	        		
	        		count_line = 0
	        		if detalhamentos_ids.count > 1
	        			detalhamentos_ids.shift
	        		end

	        		clear_content = detalhamento.content.strip.partition('Detalhamento').last
	        		tel = clear_content.to_tel

	        		puts detalhamentos_ids.count

	        		while true

	        			hash_sub_total_torpedo = {}

	        			has_sub_total_torpedo = false

	        			count_line = count_line + 1

	        			posicao_atual = count_line + detalhamento.line 

	        			e_sub = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'")

	        			e_sub = e_sub.find_by_line(posicao_atual)

	        			if e_sub.content.match("Ligações para celulares Claro") || e_sub.content.match("Ligações para celulares de outras operadoras") || e_sub.content.match("Ligações para telefones fixos")  || e_sub.content.match("Ligações para números especiais")

	        				for i in 1..500

	        					e_sub_sub = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'")
	        					e_sub_sub = e_sub_sub.find_by_line(posicao_atual + i)


	        					if e_sub_sub
	                				####
	                				if (posicao_atual + i == detalhamentos_ids.first or posicao_atual == ClaroExtract.last.line) and !e_sub_sub.content.include? "Subtotal"
	                					break
	                				elsif (posicao_atual + i == detalhamentos_ids.first or posicao_atual == ClaroExtract.last.line) and e_sub_sub.content.include? "Subtotal"

	                					tem_consumo_utilizado = true
	                					tempo = e_sub_sub.content.split[1].match(/(\d+)min/)
	                					tempo_clean = tempo[1].to_f

	                					if e_sub_sub.content.split[2].match("-")
	                						valor = 0.0
	                					else
	                						valor = e_sub_sub.content.split[2].gsub(',', '.').to_f
	                					end

	                					if sub_total_consumo_utilizado_hash.has_key?("#{tel}")
	                						valor_hash = sub_total_consumo_utilizado_hash["#{tel}"][0].to_f
	                						valor_hash = valor_hash + valor
	                						sub_total_consumo_utilizado_hash["#{tel}"] = [valor_hash, tempo_clean]
	                					else
	                						sub_total_consumo_utilizado_hash.store("#{tel}", [valor_hash, tempo_clean])
	                					end

	                					break
	                				elsif (posicao_atual + i < detalhamentos_ids.first or posicao_atual < ClaroExtract.last.line) and e_sub_sub.content.include? "Subtotal"
	                					tem_consumo_utilizado = true
	                					tempo = e_sub_sub.content.split[1].match(/(\d+)min/)
	                					begin
	                						tempo_clean = tempo[1].to_f
	                					rescue Exception => e
	                						tempo_clean = 0.to_f
	                					end
	                					
	                					valor = nil
	                					if e_sub_sub.content.split[2].match("-")
	                						valor = 0.0
	                					else
	                						valor = e_sub_sub.content.split[2].gsub(',', '.').to_f
	                					end
	                					valor_hash = 0.0
	                					if sub_total_consumo_utilizado_hash.has_key?("#{tel}")
	                						valor_hash = sub_total_consumo_utilizado_hash["#{tel}"][0].to_f
	                						valor_hash = valor_hash + valor
	                						sub_total_consumo_utilizado_hash["#{tel}"] = [valor_hash, tempo_clean]
	                					else
	                						sub_total_consumo_utilizado_hash.store("#{tel}", [valor, tempo_clean])
	                					end

	                					break
	                				end
	                				####
	                			end

	                		end
	                	elsif  e_sub.content.match("Torpedos")
	                		
	                		##>>>>>>>>>>>>>>>>>>>
	                		for i in 1..100
	                			e_sub_sub = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'")
	                			e_sub_sub = e_sub_sub.find_by_line(posicao_atual + i)
	                			if e_sub_sub
	                				if (posicao_atual + i == detalhamentos_ids.first or posicao_atual == ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'").last.line) and !e_sub_sub.content.include? "Subtotal"
	                					break
	                				end
	                				if e_sub_sub.content.strip.match("Torpedo") 
	                					if e_sub_sub.content.split(' ').count == 5 || e_sub_sub.content.split(' ').count == 8

	                						arr_subs = e_sub_sub.content.strip.split(' ')

	                						torpedo_outras_operadoras = false
	                						arr_subs.each do |arr|
	                							if arr == "Outras"
	                								torpedo_outras_operadoras = true
	                								break
	                							end
	                						end

	                						qdte = nil
	                						name = nil
	                						if torpedo_outras_operadoras
	                							qdte = arr_subs[4]
	                							name = "Torpedo - Outras Operadoras"
	                						else
	                							qdte = arr_subs[1]
	                							name = "Torpedo"
	                						end

	                						c = nil
	                						if ClaroTransactionByLine.where({kind: tel, name: name, allotment_id:lote.id, id_file:pdf.pdf_file.id}).count == 0
	                							c = ClaroTransactionByLine.new
	                						else
	                							c = ClaroTransactionByLine.where({kind: tel, name: name, allotment_id:lote.id, id_file:pdf.pdf_file.id}).first
	                						end

	                						c.name = name
	                						c.kind = tel
	                						c.value = qdte.to_f
	                						c.allotment_id = lote.id
	                						c.id_file = pdf.pdf_file.id
	                						c.save!

	                					end
	                				else
	                					if e_sub_sub.content.strip.match("Subtotal") and has_sub_total_torpedo == false
	                						hash_sub_total_torpedo.store("#{tel}", e_sub_sub.content.split(' ')[1].to_i)
	                						has_sub_total_torpedo = true

	                						break
		                                #end
		                            end 
		                        end
		                    end
		                end
		                hash_sub_total_torpedo.each do |key, value|
		                	query = "Torpedo"
		                	c = ClaroTransactionByLine.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'")
		                	c = c.where("kind = ? AND name LIKE ?", key, "%#{query}%")
		                	if c.count == 1
		                		c = c.first
		                		if c.name == "Torpedo - Outras Operadoras"
		                			c2 = ClaroTransactionByLine.new
		                			c2.name = "Torpedo"
		                			c2.kind = key
		                			c2.value = value - c.value
		                			c.allotment_id = lote.id
		                			c.id_file = pdf.pdf_file.id
		                			c2.save! 
		                		else
		                			if c.name == "Torpedo"
		                				c2 = ClaroTransactionByLine.new
		                				c2.name = "Torpedo - Outras Operadoras"
		                				c2.kind = key
		                				c2.value = value - c.value
		                				c.allotment_id = lote.id
		                				c.id_file = pdf.pdf_file.id
		                				c2.save! 
		                			end
		                		end
		                	else
		                		break
		                	end
		                end
	                		##>>>>>>>>>>>>>>>>>>>
	                		
	                	elsif e_sub.content.match("Interurbanas") or e_sub.content.match("Interur")
	                		#####>>>>>>>>>>>>>>>>>>>>>>>
	                		for i in 1..500
	                			e_sub_sub = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'")
	                			e_sub_sub = e_sub_sub.find_by_line(posicao_atual + i)
	                			if e_sub_sub
	                				if (posicao_atual + i == detalhamentos_ids.first or posicao_atual == ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'").last.line) and !e_sub_sub.content.include? "Subtotal"
	                					break
	                				else
	                					if e_sub_sub.content.include? "Subtotal"

	                						tem_ligacoes_interurbana = true
	                						tempo = e_sub_sub.content.split[1].match(/(\d+)min/)
	                						tempo_clean = tempo[1].to_f
	                						valor = nil

	                						if e_sub_sub.content.split[2].match("-")
	                							valor = 0.0
	                						else
	                							valor = e_sub_sub.content.split[2].gsub(',', '.').to_f
	                						end

	                						valor_hash = 0.0
	                						if sub_total_hash_interurbano.has_key?("#{tel}")
	                							valor_hash = sub_total_hash_interurbano["#{tel}"][0].to_f
	                							valor_hash = valor_hash + valor
	                							sub_total_hash_interurbano["#{tel}"] = [valor_hash, tempo_clean]
	                						else
	                							sub_total_hash_interurbano.store("#{tel}", [valor, tempo_clean])
	                						end

	                						break
	                					end
	                				end
	                			end
	                		end
	                		#>>>>>>>>>>>>>>>>>>>>>>>>>>>
	                	elsif e_sub.content.match("Mbytes") and !e_sub.content.include?("País")
	                		#>>>>>>>>>>>>>>>>>>>>>>>>>>>
	                		for i in 1..500

	                			e_sub_sub = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'")
	                			e_sub_sub = e_sub_sub.find_by_line(posicao_atual + i)
	                			
	                			if e_sub_sub
	                				if (posicao_atual + i == detalhamentos_ids.first or posicao_atual == ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'").last.line) and !e_sub_sub.content.include? "Subtotal"
	                					break
	                				elsif e_sub_sub.content.include? "Subtotal"
	                					tem_dados = true

	                					valor = e_sub_sub.content.split[1].gsub('.', '').gsub(',', '.').to_f
	                					if sub_total_hash_dados.has_key?("#{tel}")

	                						valor_hash = sub_total_hash_dados["#{tel}"].to_f
	                						valor_hash = valor_hash + valor
	                						sub_total_hash_dados["#{tel}"] = valor

	                					else
	                						sub_total_hash_dados.store("#{tel}",valor)
	                					end

	                				elsif e_sub_sub.content.include? "TotalEEEE" or e_sub_sub.content.include? "Total" and ! e_sub_sub.content.include? "Subtotal" and ! e_sub_sub.content.include? "Total Cobrado"

	                					#binding.pry

	                					# ----->   (/\d*.\d*/).to_s}

	                					arr = e_sub_sub.content.gsub('E', '').gsub('Total', '').gsub('.', '').gsub(',', '.').split

	                					if sub_total_hash_dados_m2m_1.has_key?("#{tel}")
	                						valor_hash = sub_total_hash_dados_m2m_1["#{tel}"].to_f 
	                						valor_hash = valor_hash + arr[0].to_f
	                						sub_total_hash_dados_m2m_1["#{tel}"] = valor_hash
	                					else
	                						sub_total_hash_dados_m2m_1.store("#{tel}",arr[0].to_f)
	                					end


	                					if sub_total_hash_dados_m2m_2.has_key?("#{tel}")
	                						valor_hash = sub_total_hash_dados_m2m_2["#{tel}"].to_f 
	                						valor_hash = valor_hash + arr[1].to_f
	                						sub_total_hash_dados_m2m_2["#{tel}"] = valor_hash
	                					else
	                						sub_total_hash_dados_m2m_2.store("#{tel}",arr[1].to_f)
	                					end

	                					break
	                				end
	                			end
	                		end
	                		#>>>>>>>>>>>>>>>>>>>>>>>>>>>
	                	end

	                	if posicao_atual == detalhamentos_ids.first or posicao_atual == ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'").last.line
	                		break
	                	end 

	                end

	                if !tem_consumo_utilizado

	                	c = nil

	                	if ClaroTransactionByLine.where({kind: tel, name: "Consumo Utilizado", allotment_id:lote.id, id_file:pdf.pdf_file.id}).count == 0
	                		c = ClaroTransactionByLine.new
	                	else
	                		c = ClaroTransactionByLine.where({kind: tel, name: "Consumo Utilizado", allotment_id:lote.id, id_file:pdf.pdf_file.id}).first
	                	end

		                #binding.pry

		                c.kind = tel
		                c.name = "Consumo Utilizado"
		                c.value = 0.0.to_f
		                c.use_time = 0.0.to_f
		                c.allotment_id = lote.id
		                c.id_file = pdf.pdf_file.id
		                c.save!
		            end

		            if !tem_ligacoes_interurbana
		            	c = nil
		            	if ClaroTransactionByLine.where({kind: tel, name: "Interurbano", allotment_id:lote.id, id_file:pdf.pdf_file.id}).count == 0
		            		c = ClaroTransactionByLine.new
		            	else
		            		c = ClaroTransactionByLine.where({kind: tel, name: "Interurbano", allotment_id:lote.id, id_file:pdf.pdf_file.id}).first
		            	end

		            	c.kind = tel
		            	c.name = "Interurbano"
		            	c.value = 0.0.to_f
		            	c.use_time = 0.0.to_f
		            	c.allotment_id = lote.id
		            	c.id_file = pdf.pdf_file.id
		            	c.save!
		            end

		            if ! tem_dados

		            	c = nil
		            	if ClaroTransactionByLine.where({kind: tel, name: "Dados", allotment_id:lote.id, id_file:pdf.pdf_file.id}).count == 0
		            		c = ClaroTransactionByLine.new
		            	else
		            		c = ClaroTransactionByLine.where({kind: tel, name: "Dados", allotment_id:lote.id, id_file:pdf.pdf_file.id}).first
		            	end

		            	c.kind = tel
		            	c.name = "Dados"
		            	c.value = 0.0.to_f
		            	c.use_time = 0.0.to_f
		            	c.allotment_id = lote.id
		            	c.id_file = pdf.pdf_file.id
		            	c.save!

		            end 

		        end

		        sub_total_consumo_utilizado_hash.each do |key, value|

		        	c = nil
		        	if ClaroTransactionByLine.where({kind: key, name: "Consumo Utilizado", allotment_id:lote.id, id_file:pdf.pdf_file.id}).count == 0
		        		c = ClaroTransactionByLine.new
		        	else
		        		c = ClaroTransactionByLine.where({kind: key, name: "Consumo Utilizado", allotment_id:lote.id, id_file:pdf.pdf_file.id}).first
		        	end

		        	c.kind = key
		        	c.name = "Consumo Utilizado"
		        	c.value = value[0].to_f
		        	c.use_time = value[1].to_f
		        	c.allotment_id = lote.id
		        	c.id_file = pdf.pdf_file.id
		        	c.save!

		        end


		        sub_total_hash_interurbano.each do |key, value|

		        	c = nil

		        	if ClaroTransactionByLine.where({kind: key, name: "Interurbano", allotment_id:lote.id, id_file:pdf.pdf_file.id}).count == 0
		        		c = ClaroTransactionByLine.new
		        	else
		        		c = ClaroTransactionByLine.where({kind: key, name: "Interurbano", allotment_id:lote.id, id_file:pdf.pdf_file.id}).first
		        	end

		        	c.kind = key
		        	c.name = "Interurbano"
		        	c.value = value[0].to_f
		        	c.use_time = value[1].to_f
		        	c.allotment_id = lote.id
		        	c.id_file = pdf.pdf_file.id
		        	c.save!
		        end

		        sub_total_hash_dados.each do |key, value|

		        	c = nil

		        	if ClaroTransactionByLine.where({kind: key, name: "Dados", allotment_id:lote.id, id_file:pdf.pdf_file.id}).count == 0
		        		c = ClaroTransactionByLine.new
		        	else
		        		c = ClaroTransactionByLine.where({kind: key, name: "Dados", allotment_id:lote.id, id_file:pdf.pdf_file.id}).first
		        	end

		        	c.kind = key
		        	c.name = "Dados"
		        	c.allotment_id = lote.id
		        	c.id_file = pdf.pdf_file.id
		        	c.use_time = value.to_f
		        	c.valor_total = sub_total_hash_dados_m2m_1[key].to_f
		        	c.valor_cobrado = sub_total_hash_dados_m2m_2[key].to_f
		        	c.save!
		        end


		        #quarta fase
		        ClaroTransactionByLineClaro.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").destroy_all

		        #Detalhamento de ligações e serviços do celular
		        query = "Detalhamento de ligações e serviços do celular"
		        detalhamentos = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'").order("id ASC")
		        detalhamentos = detalhamentos.where("content LIKE ?", "%#{query}%").order("id ASC")
		        proxima_linha = 0

		        detalhamentos_ids = []

		        detalhamentos.each do |detalhamento|
		        	detalhamentos_ids << detalhamento.line
		        end

		        sub_total_consumo_claro_hash    = {}


		        detalhamentos.each do |detalhamento|

		        	count_line = 0
		        	if detalhamentos_ids.count > 1
		        		detalhamentos_ids.shift
		        	end
		        	clear_content = detalhamento.content.strip.partition('Detalhamento').last
		        	tel = clear_content.to_tel

		            #zerando variaveis
		            tem_consumo_utilizado       = false
		            ##################

		            puts detalhamentos_ids.count
		            
		            while true

		            	count_line = count_line + 1

		            	posicao_atual = count_line + detalhamento.line 
		            	e_sub = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'")
		            	e_sub = e_sub.find_by_line(posicao_atual)

		            	if e_sub.content.match("Ligações para celulares Claro")

		            		for i in 1..500

		            			e_sub_sub = ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'")
		            			e_sub_sub = e_sub_sub.find_by_line(posicao_atual + i)

		            			if e_sub_sub

		            				if (posicao_atual + i == detalhamentos_ids.first or posicao_atual == ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'").last.line) and !e_sub_sub.content.include? "Subtotal"
		            					break
		            				elsif (posicao_atual + i == detalhamentos_ids.first or posicao_atual == ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'").last.line) and e_sub_sub.content.include? "Subtotal"

		            					tem_consumo_utilizado = true
		            					tempo = e_sub_sub.content.split[1].match(/(\d+)min/)
		            					tempo_clean = tempo[1].to_f

		            					if e_sub_sub.content.split[2].match("-")
		            						valor = 0.0
		            					else
		            						valor = e_sub_sub.content.split[2].gsub(',', '.').to_f
		            					end

		            					if sub_total_consumo_claro_hash.has_key?("#{tel}")
		            						valor_hash = sub_total_consumo_claro_hash["#{tel}"][0].to_f
		            						valor_hash = valor_hash + valor
		            						sub_total_consumo_claro_hash["#{tel}"] = [valor_hash, tempo_clean]
		            					else
		            						sub_total_consumo_claro_hash.store("#{tel}", [valor_hash, tempo_clean])
		            					end

		            					break
		            				elsif (posicao_atual + i < detalhamentos_ids.first or posicao_atual < ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'").last.line) and e_sub_sub.content.include? "Subtotal"
		            					tem_consumo_utilizado = true
		            					tempo = e_sub_sub.content.split[1].match(/(\d+)min/)

		            					begin
		            						tempo_clean = tempo[1].to_f
		            					rescue Exception => e
		            						tempo_clean = 0.to_f
		            					end


		            					valor = nil
		            					if e_sub_sub.content.split[2].match("-")
		            						valor = 0.0
		            					else
		            						valor = e_sub_sub.content.split[2].gsub(',', '.').to_f
		            					end
		            					valor_hash = 0.0
		            					if sub_total_consumo_claro_hash.has_key?("#{tel}")
		            						valor_hash = sub_total_consumo_claro_hash["#{tel}"][0].to_f
		            						valor_hash = valor_hash + valor
		            						sub_total_consumo_claro_hash["#{tel}"] = [valor_hash, tempo_clean]
		            					else
		            						sub_total_consumo_claro_hash.store("#{tel}", [valor, tempo_clean])
		            					end

		            					break
		            				end
		            			end
		            		end
		            	end       

		            	if posicao_atual == detalhamentos_ids.first or posicao_atual == ClaroExtract.where("allotment_id = #{lote.id} AND id_file = '#{pdf.pdf_file.id}'").last.line
		            		break
		            	end   
		            end

		            if !tem_consumo_utilizado

		            	c = nil

		            	if ClaroTransactionByLineClaro.where({kind: tel, name: "Consumo Utilizado", allotment_id:lote.id, id_file:pdf.pdf_file.id}).count == 0
		            		c = ClaroTransactionByLineClaro.new
		            	else
		            		c = ClaroTransactionByLineClaro.where({kind: tel, name: "Consumo Utilizado", allotment_id:lote.id, id_file:pdf.pdf_file.id}).first
		            	end

		                #binding.pry

		                c.kind = tel
		                c.name = "Ligações Cel Claro"
		                c.value = 0.0.to_f
		                c.use_time = 0.0.to_f
		                c.allotment_id = lote.id
		                c.id_file = pdf.pdf_file.id
		                c.save!
		            end
		        end

		        sub_total_consumo_claro_hash.each do |key, value|
		        	c = nil
		        	if ClaroTransactionByLineClaro.where({kind: key, name: "Consumo Utilizado", allotment_id:lote.id, id_file:pdf.pdf_file.id}).count == 0
		        		c = ClaroTransactionByLineClaro.new
		        	else
		        		c = ClaroTransactionByLineClaro.where({kind: key, name: "Consumo Utilizado", allotment_id:lote.id, id_file:pdf.pdf_file.id}).first
		        	end

		        	c.kind = key
		        	c.name = "Ligações Cel Claro"
		        	c.value = value[0].to_f
		        	c.use_time = value[1].to_f
		        	c.allotment_id = lote.id
		        	c.id_file = pdf.pdf_file.id
		        	c.save!
		        end
		        #>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


		        ####>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		        #quinta parte e final
		        ClaroManagerByLine.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").destroy_all

		        query = "Detalhamento de ligações e serviços do celular"

		        detalhamentos = ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").order("id ASC")
		        detalhamentos = detalhamentos.where("content LIKE ?", "%#{query}%").order("id ASC")

		        lines = []
		        contents = []
		        temp_lines = []

		        detalhamentos.each do |detalhamento|
		        	lines << detalhamento.line
		        	contents << detalhamento.content
		        	temp_lines << detalhamento.line
		        end


		        lines.each do |line|
		        	temp_lines.shift
		        	count           = 0

		        	entrou_descricao = false

		        	clear_content = ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ")
		        	clear_content = clear_content.find_by_line(line).content
		        	tel = clear_content.to_tel

		        	while true
		        		count += 1
		        		next_line = line + count
		        		if temp_lines.empty?
		        			entrou_descricao = false
		        			if next_line == ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").last.line
		        				break
		        			else
		        				extract = ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ")
		        				extract = extract.find_by_line(next_line)

		        				if extract.content.match("EEEE") and entrou_descricao
		                            #binding.pry
		                            break
		                        end

		                        if entrou_descricao

		                        	if !extract.content.strip.empty?

		                        		value = extract.content.split.last.gsub('.', '').gsub(',', '.').to_f

		                        		contents_strings = []

		                        		extract.content.split.each do |s_item|
		                        			if s_item.include? extract.content.split.last
		                        				break
		                        			end
		                        			contents_strings << s_item
		                        		end

		                        		item = contents_strings.map { |i| i.to_s }.join(" ")

		                        		consolidate_line = ClaroManagerByLine.new
		                        		consolidate_line.item = item
		                        		consolidate_line.value = value
		                        		consolidate_line.kind = tel
		                        		consolidate_line.allotment_id = lote.id
		                        		consolidate_line.id_file = pdf.pdf_file.id
		                        		consolidate_line.save!

		                        	end
		                        end

		                        if extract.content.match("Descrição")
		                        	entrou_descricao = true
		                        end

		                    end

		                else

		                	if line + count == temp_lines.first and !ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").find_by_line(next_line).content.include? "Detalhamento de ligações e serviços"
		                		break
		                	elsif line + count == temp_lines.first and ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").find_by_line(next_line).content.include? "Detalhamento de ligações e serviços" and ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").find_by_line(next_line).content.split.count > 15
		                        #binding.pry
		                        contents_strings = []
		                        
		                        ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").find_by_line(next_line).content.split.each do |s_item|
		                        	if s_item.include? "Detalhamento"
		                        		break
		                        	else
		                        		contents_strings << s_item
		                        	end
		                        end

		                        value = contents_strings.last.gsub('.', '').gsub(',', '.').to_f
		                        
		                        contents_strings = []

		                        ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").find_by_line(next_line).content.split.each do |s_item|
		                        	if s_item.include? value.to_s
		                        		break
		                        	else
		                        		contents_strings << s_item
		                        	end
		                        end

		                        item = contents_strings.map { |i| i.to_s }.join(" ")

		                        consolidate_line = ClaroManagerByLine.new
		                        consolidate_line.item = item
		                        consolidate_line.value = value
		                        consolidate_line.kind = tel
		                        consolidate_line.allotment_id = lote.id
		                        consolidate_line.id_file = pdf.pdf_file.id
		                        consolidate_line.save!

		                    else
		                    	extract = ClaroExtract.where("allotment_id = #{lote.id} and id_file = '#{pdf.pdf_file.id}' ").find_by_line(next_line)

		                    	if extract.content.match("Continuação") and !   extract.content.include? "Mensalidades e Pacotes"
		                    		break
		                    	end    

		                    	if extract.content.match("EEEE") and entrou_descricao
		                            #binding.pry
		                            break
		                        end

		                        if entrou_descricao

		                        	if !extract.content.strip.empty?

		                        		value = extract.content.split.last.gsub('.', '').gsub(',', '.').to_f

		                        		contents_strings = []

		                        		extract.content.split.each do |s_item|
		                        			if s_item.include? extract.content.split.last
		                        				break
		                        			end
		                        			contents_strings << s_item
		                        		end

		                        		item = contents_strings.map { |i| i.to_s }.join(" ")

		                        		consolidate_line = ClaroManagerByLine.new
		                        		consolidate_line.item = item
		                        		consolidate_line.value = value
		                        		consolidate_line.kind = tel
		                        		consolidate_line.allotment_id = lote.id
		                        		consolidate_line.id_file = pdf.pdf_file.id
		                        		consolidate_line.save!

		                        	end
		                        end

		                        if extract.content.match("Descrição")
		                        	entrou_descricao = true
		                        end

		                    end
		                end
		            end
		        end

		    elsif pdf.company_id == 2

		    	count = 0

		    	VivoExtract.where("allotment_id = #{lote.id} and pdf_file_id = '#{pdf.id}' ").destroy_all
		    	VivoTransationByLine.where("allotment_id = #{lote.id} and pdf_file_id = '#{pdf.id}' ").destroy_all

		    	f = File.open(extract_file, "r")

		    	f.each_line do |line|

		    		count = count + 1
		    		e = VivoExtract.new
		    		e.line = count
		    		e.content = line.gsub("VEJA O USO DETALHADO DO VIVO", "\nVEJA O USO DETALHADO DO VIVO")
		    		e.allotment_id = lote.id
		    		e.pdf_file_id = pdf.id
		    		e.save!

		    	end

		    	f.close

		    	VivoHeaderManager.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id}" ).destroy_all

		    	query = "Serviços Contratados"
		    	vivo = VivoExtract.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id} AND content LIKE '%#{query}%' ").order('id ASC').first
		    	inicio = vivo.line


		    	query = "Subtotal"
		    	vivo = 	VivoExtract.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id} AND content LIKE '%#{query}%' ").order('id ASC').first
		    	fim = vivo.line

		    	((inicio + 1)..(fim - 1)).each do |index|

		    		v = VivoExtract.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id}").order('id ASC')
		    		v = v.where("line = #{index}").first

		    		if v.content.split.count > 3
		    			contracted_amount = v.content.split.last.gsub(".", "").gsub(",", ".").to_f
		    			number_of_lines = v.content.split[-2].strip
		    			amount_of_plans = v.content.split[-3].strip
		    			item = ""
		    			v.content.split.each do | caracteres |
		    				if caracteres == amount_of_plans
		    					break
		    				end
		    				item =  item + "#{caracteres} "
		    			end
		    			vivo = VivoHeaderManager.create(contracted_amount:contracted_amount, number_of_lines:number_of_lines, amount_of_plans:amount_of_plans)
		    			vivo.item = "Serviços Contratados"
		    			vivo.contracted_service = item
		    			vivo.allotment_id = lote.id
		    			vivo.pdf_file_id = pdf.id
		    			vivo.save!
		    		else
						#binding.pry
					end				
				end 

				query = "Utilização Dentro do Plano/Pacote"
				vivo = VivoExtract.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id} AND content LIKE '%#{query}%' ").order('id ASC').first
				inicio = vivo.line

				query = "Utilização Acima do Contratado"
				vivo = VivoExtract.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id} AND content LIKE '%#{query}%' ").order('id ASC').first
				fim = vivo.line - 2

				((inicio + 1)..(fim)).each do |index|
					v = VivoExtract.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id}").order('id ASC')
					v = v.where("line = #{index}").first

					if v.content.split.count > 3
						
						vivo = VivoHeaderManager.new
						vivo.item = "Utilização Dentro do Plano/Pacote"
						vivo.contracted_amount = v.content.split.last.gsub(".", "").gsub(",", ".").to_f
						#binding.pry
						enclosed_tmp = v.content.gsub(" min", "min").gsub(" GB", "GB")	
						
						if enclosed_tmp.split[-3].strip.include? "min"
							vivo.type_enclosed = 0
						elsif enclosed_tmp.split[-3].strip.include? "GB"
							vivo.type_enclosed = 1
						else
							vivo.type_enclosed = 2
						end

						vivo.enclosed = enclosed_tmp.split[-3].strip.gsub(".", "").to_i


						if enclosed_tmp.split[-2].strip.include? "m" and enclosed_tmp.split[-2].strip.include? "s" 
							vivo.type_utilized = 0
						elsif enclosed_tmp.split[-2].strip.include? "GB"
							vivo.type_utilized = 1
						else
							vivo.type_utilized = 2
						end

						vivo.utilized = enclosed_tmp.split[-2].strip.gsub(".", "").to_i

						contracted_service = ""
						v.content.gsub(" min", "min").gsub(" GB", "GB").split.each do | caracter |

							if caracter == v.content.gsub(" min", "min").gsub(" GB", "GB").split[-3].strip
								break
							end
							contracted_service = contracted_service + "#{caracter} "
						end

						vivo.contracted_service = contracted_service.strip
						vivo.allotment_id = lote.id
						vivo.pdf_file_id = pdf.id

						vivo.save!
					end
				end

				query = "Utilização Acima do Contratado"
				vivo = VivoExtract.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id} AND content LIKE '%#{query}%' ").order('id ASC').first
				inicio = vivo.line

				query = "Continuação"
				vivo = VivoExtract.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id} AND content LIKE '%#{query}%' ").order('id ASC').first
				fim = vivo.line - 3


				((inicio + 1)..(fim)).each do |index|
					
					v = VivoExtract.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id}").order('id ASC')
					v = v.where("line = #{index}").first

					if v.content.split.count > 0 and !v.content.include? "No Brasil - Em Roaming"
						
						vivo = VivoHeaderManager.new
						vivo.item = "Utilização Acima do Contratado"
						vivo.contracted_amount = v.content.split.last.gsub(".", "").gsub(",", ".").to_f
						vivo.utilized = v.content.split[-2].strip.gsub(".", "").to_i

						if v.content.split[-2].strip.include? "MB"
							vivo.type_utilized = 3
						elsif v.content.split[-2].strip.include? "m" and v.content.split[-2].strip.include? "s"
							vivo.type_utilized = 0
						else
							vivo.type_utilized = 2 #regular integer
						end

						vivo.allotment_id = lote.id
						vivo.pdf_file_id = pdf.id
						vivo.save!

					end

				end	
				
				query = "VEJA O USO DETALHADO"
				vivos = VivoExtract.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id} AND content LIKE '%#{query}%' ").order('id ASC')

				vivos_tmp = []

				hash_contratado = { name: "SERVIÇOS CONTRATADOS", itens:[
					'PLANO VIP ASSINATURA', 
					'SERVICO GESTAO', 
					'Ligações Locais - Para Celulares Vivo', 
					'Ligações Locais - Para Celulares de Outras Operadoras', 
					'Ligações Locais - Para Fixo de Outras Operadoras', 
					'Ligações Locais - Para Grupo', 
					'PACOTE GESTAO COMPLETO', 
					'PACOTE LD FULL', 
					'INTRAGRUPO LOCAL',
					'PACOTE VIP',
					'PACOTE LD 1',
					'SMS COMPARTILHADO',
					'Torpedo SMS',
					'INTERNET MOVEL',
					'SERVICO GESTAO',
				]
			}


			vivos.each do |vivo|
				vivos_tmp << vivo.line
			end

			vivos.each do |vivo|

				if vivos_tmp.count > 0

					vivos_tmp.shift

					count = 0

					while true

						count +=1

						if vivos_tmp.first == vivo.line + count
							binding.pry
							break
						else
								#binding.pry
								vivo_new = VivoExtract.where("allotment_id = #{lote.id} AND pdf_file_id = #{pdf.id}").order('id ASC')
								vivo_new = vivo_new.where("line = ?", vivo.line + count).first

								has_item = hash_contratado[:itens].any? { |word| vivo_new.content.include?(word) }

								if has_item && vivo_new.content.strip.length > 0
									
									valor = vivo_new.content.split.last.gsub(".", "").gsub(",", ".")

									if vivo_new.content.include? "PLANO VIP ASSINATURA"
										
										vivo_transation_by_line = VivoTransationByLine.new
										vivo_transation_by_line.amount = valor
										vivo_transation_by_line.name = "PLANO VIP ASSINATURA"
										vivo_transation_by_line.allotment_id = lote.id
										vivo_transation_by_line.pdf_file_id = pdf.id
										vivo_transation_by_line.save!

										binding.pry

									end

								end

							end

						end

					elsif vivos_tmp.count == 0
					end
				end

			end
	        ####>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	    end

	    lote.completed!

	    render js: 'completed();' 

	end

end


class String


	def get_contracted_service_vivo

	end

	def numeric?
		Float(self) != nil rescue false
	end

	def to_tel

		tel = ""

		initial_tel = false

		self.strip.split('').each do |content_tel|

			if content_tel == "("
				initial_tel = true
			end

			if initial_tel == true
				tel = tel + "#{content_tel}"
			end

		end


		return tel

	end
end

