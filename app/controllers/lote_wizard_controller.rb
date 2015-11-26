class LoteWizardController < ApplicationController
	
	before_action :authenticate_user!

  before_filter :authorize_admin, only: :index

  def authorize_admin
    redirect_to :back, :status => 401 unless current_user.admin
    #redirects to previous page
  end

	include Wicked::Wizard

	steps :add_lote, :add_file, :show_analytics 

	def show
    	@user = current_user
    	
    	case step
    		when :find_friends
      			@friends = @user.find_friends
    	end
    	render_wizard
  end
end
