RailsAdmin.config do |config|


  config.model ClaroExtract do
    
    list do

      items_per_page 200

      field :allotment_id do
        sort_reverse false
      end

      field :id_file do
        sort_reverse false
        column_width 100
      end

      sort_by :line

      field :line do
        sort_reverse false
      end

      field :content do
        sort_reverse false
      end
      
    end

  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  #config.authorize_with do |controller|
      #redirect_to main_app.root_path unless current_user.try(:admin?)
  #end

  
end
