class FansController < ApplicationController
  before_action :set_fan, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user! , only: [:new, :create, :is_email_exist, :fb_create]
  load_and_authorize_resource :only => [:index, :show, :new, :edit, :create, :update, :destroy]

  respond_to :html

  def index
    @fans = Fan.all
    respond_with(@fans)
  end

  def show
    if @fan.city.present?
      location = Geocoder.search(@fan.city)
      @hash = Gmaps4rails.build_markers(location.first) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
        marker.infowindow "hello!"
      end
    end
    # raise @hash.to_json
    respond_with(@fan)
  end

  def new
    @fan = Fan.new
    @fan.build_user
    @fan.fan_genres.build
    session["user_role"] = params[:controller]
    @fb_user = session["devise.facebook_data"] unless session["devise.facebook_data"].nil?
    unless @fb_user.nil?
      # raise @fb_user.inspect
      @fan.first_name = @fb_user['info']['first_name']
      @fan.last_name = @fb_user['info']['last_name']
      @fan.date_of_birth = @fb_user['extra']['raw_info']["birthday"]
      # @fan.gender = @fb_user['extra']['raw_info']['gender']
      @fan.user.username = @fb_user['extra']['raw_info']['id']
      @fan.user.email = @fb_user['info']['email']
      @fan.user.provider = @fb_user['provider']
      @fan.user.uid = @fb_user['uid']
      @fan.user.password = @fan.user.password_confirmation = Devise.friendly_token[0,20]
    end
    respond_with(@fan)
  end

  def edit

  end

  def create
    # raise params.inspect
    @fan = Fan.new(fan_params)
    @fan.user.user_role = params[:controller]
    if @fan.save
      flash[:notice] = "#{t('devise.registrations.signed_up')}"
      # flash[:notice] = "#{t('devise.confirmations.send_instructions')}"
      redirect_to root_path
    else
      respond_with(@fan)
    end
  end

  def is_email_exist
    @role_type = params[:controller].singularize.to_sym
    @user = User.is_email_exist(params[@role_type][:user_attributes][:email],current_user)
  end

  def update
    flash[:notice] = 'Fan was successfully updated.' if @fan.update(fan_params)
    respond_with(@fan)
  end

  def destroy
    @fan.destroy
    respond_with(@fan)
  end

  private
    def set_fan
      @fan = Fan.find(params[:id])
    end

    def fan_params
      params.require(:fan).permit(:first_name, :last_name, :gender, :date_of_birth, :address, :city, :country_id,
                                  :agree_to_privacy, :subscription, :user_id,
                                  :user_attributes => [:username, :email, :password, :password_confirmation, :user_role, :provider, :uid],
                                  :genre_ids => [])
    end
end
