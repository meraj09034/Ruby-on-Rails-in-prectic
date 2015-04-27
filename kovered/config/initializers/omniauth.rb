Rails.application.config.middleware.use OmniAuth::Builder do
  # Default usage, this will give you offline access and a refresh token
  # using default scopes 'email' and 'profile'
  #
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], {
    :name => "google",
  	:scope => "email, profile, plus.me, http://gdata.youtube.com",
	  :prompt => "select_account",
    :image_aspect_ratio => "square",
    :image_size => 50
  }

end