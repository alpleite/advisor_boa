require 'rails_helper'

RSpec.describe TypeCompany, :type => :model do
  
	describe 'name validation' do
		
		context 'name is present' do
			before(:each) do
        		@type = TypeCompany.new(name: 'tipo novo')
      		end

      		it 'is valid with present name' do
        		expect(@type.errors[:name]).to be_empty
      		end

		end

		context 'name is not present' do
			before(:each) do
				@type = TypeCompany.create
			end

			it 'has an error on name attribute' do
				expect(@type.errors[:name].length).to eq(1)
			end

		end

	end

end
