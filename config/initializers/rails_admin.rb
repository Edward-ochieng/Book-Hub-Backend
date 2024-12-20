RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    authenticate_or_request_with_http_basic do |username, password|
      username == 'Edward' && password == 'Edward@12'
    end
  end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

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

  config.model 'PublicActivity::Activity' do
    list do
      field :id
      field :key
      field :owner
      field :trackable
      field :recipient
      field :created_at
    end

    show do
      field :id
      field :key
      field :owner
      field :trackable
      field :recipient
      field :parameters
      field :created_at
    end
  end
end
