class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout Proc.new { |controller| controller.devise_controller? ? 'devise' : 'application' }

  def after_sign_in_path_for(resource)
    
  	if resource.admin?
  		root_path
  	else
  		 consumer_area_reports_path
  	end

  end


end
