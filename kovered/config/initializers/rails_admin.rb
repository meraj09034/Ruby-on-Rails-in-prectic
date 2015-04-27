RailsAdmin.config do |config|

  ### Popular gems integration
  config.main_app_name = Proc.new { |controller| [ "Kovered360", "Admin - #{controller.params[:action].try(:titleize)}" ] }
  config.included_models = ['Fan', 'Artist', 'Executive' , 'Country', 'Genre', 'MusicGenre', 'User']

  config.model 'Fan' do
    list do
      field :id
      field :first_name
      field :last_name
      field :city
      field :country
      field :user
      field :genres
      field :date_of_birth
    end
    navigation_label 'User'
    weight -1
    label "Music Lover"
    label_plural "Music Lovers"
  end
  config.model 'Artist' do
    list do
      field :id
      field :first_name
      field :last_name
      field :gender
      field :band_name
      field :genre
      field :user
      field :city
      field :country
      field :date_of_birth
    end
    edit do
      field :first_name
      field :last_name
      field :gender
      field :band_name
      field :genre
      field :user
      field :city
      field :country
      field :date_of_birth
    end
    navigation_label 'User'
    weight -1
  end
  config.model 'Executive' do
    list do
      field :id
      field :first_name
      field :last_name
      field :gender
      field :genres
      field :website
      field :date_of_birth
      field :city
      field :country
      field :user
    end
    edit do
      field :first_name
      field :last_name
      field :gender
      field :genres
      field :website
      field :date_of_birth
      field :city
      field :country
      field :user
    end
    navigation_label 'User'
    weight -1
  end
  config.model 'User' do
    list do
      field :id
      field :username
      field :email
      field :fan
      field :artist
      field :executive
      field :admin
      field :provider
      field :uid
      field :sign_in_count
      field :current_sign_in_at
      field :last_sign_in_at
      field :current_sign_in_ip
      field :last_sign_in_ip
      sort_by :id
      items_per_page 100
    end
    edit do
      field :username, :string
      field :email
      field :provider
      field :uid
    end
    navigation_label 'User'
    # navigation_icon 'icon-user'
    weight -1
  end
  config.model 'Genre' do
    navigation_label 'Music'
    weight 0
  end
  config.model 'MusicGenre' do
    navigation_label 'Music'
    weight 0
  end
  config.model 'Country' do
    navigation_label 'Others'
    weight 1
    list do
      field :id
      field :iso_code
      field :name
    end
  end

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard
    index                         # mandatory
    new do
      only ['Country', 'Genre', 'MusicGenre']
    end
    export
    bulk_delete do
      only ['Fan', 'Artist', 'Executive' ]
    end
    show
    edit
    delete do
      only ['Fan', 'Artist', 'Executive' ]
    end
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
