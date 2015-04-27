class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :default_time_zone_present_time, :present_time, :country, :music_genre
  # layout :layout_by_resourcec
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  # check_authorization

  after_filter :store_location
  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end


  def default_time_zone_present_time
    server_time = Time.now
    server_time_to_gmt = server_time.getgm
    @local_tzone_time = server_time

    time_zone = nil
    unless time_zone.nil?
      unless time_zone.config_value.nil?
        zone = TimeZone.find(time_zone.config_value)
        if zone.difference_type=="+"
          @local_tzone_time = server_time_to_gmt + zone.time_difference
        else
          @local_tzone_time = server_time_to_gmt - zone.time_difference
        end
      end
    end
    # raise @local_tzone_time.inspect
    return @local_tzone_time
  end

  def present_time
    default_time_zone_present_time.strftime(t('date.formats.default'))
  end


  def country
    @country = Country.all.map{|g| [g.name, g.id]}
  end

  def music_genre
    MusicGenre.all.map do |music_genre|
      [music_genre.name, music_genre.genres.map { |c| [c.name, c.id] }]
    end
  end

  private

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to session[:previous_url] || root_path
  end

  protected


=begin
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end
=end

  def after_sign_in_path_for(resource)

    # root_path
    if current_user.fan
      fan_path(resource.fan)
    elsif current_user.artist
      artist_path(resource.artist)
    elsif current_user.executive
      executive_path(resource.executive)
    else
      root_path
    end
    # case resource.fan
    #   when resource.fan then
    # end
  end

  def configure_permitted_parameters

    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :provider, :uid) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :provider, :uid) }
  end

  def layout_by_resource
    if devise_controller? && action_name == "new"
      "login_application"
    else
      "application"
    end
  end
end
