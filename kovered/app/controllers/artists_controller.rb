class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user! , only: [:new, :create, :is_email_exist]
  load_and_authorize_resource :only => [:index, :show, :new, :edit, :create, :update, :destroy]


  respond_to :html

  def index
    @artists = Artist.all
    respond_with(@artists)
  end

  def show
    respond_with(@artist)
  end

  def new
    @artist = Artist.new
    @artist.build_user
    # @artist.fan_genres.build
    session["user_role"] = params[:controller]
    # @fb_user = session["devise.google_data"] unless session["devise.google_data"].nil?
    @fb_user = session["devise.facebook_data"] unless session["devise.facebook_data"].nil?
    unless @fb_user.nil?
      # raise @fb_user.inspect
      @artist.first_name = @fb_user['info']['first_name']
      @artist.last_name = @fb_user['info']['last_name']
      @artist.date_of_birth = @fb_user['extra']['raw_info']["birthday"]
      @artist.gender = @fb_user['extra']['raw_info']['gender']
      @artist.user.username = @fb_user['extra']['raw_info']['id']
      @artist.user.email = @fb_user['info']['email']
      @artist.user.provider = @fb_user['provider']
      # @artist.user.token = @fb_user['credentials']['token']
      @artist.user.uid = @fb_user['uid']
      @artist.user.password = @artist.user.password_confirmation = Devise.friendly_token[0,20]
    end
    respond_with(@artist)
  end

  def edit
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.user.user_role = params[:controller]
    if @artist.save
      flash[:notice] = "#{t('devise.registrations.signed_up')}"
      # flash[:notice] = "#{t('devise.confirmations.send_instructions')}"
      redirect_to root_path
    else
      respond_with(@artist)
    end
  end

  def is_email_exist
    @role_type = params[:controller].singularize.to_sym
    @user = User.is_email_exist(params[@role_type][:user_attributes][:email],current_user)
  end

  def update
    flash[:notice] = 'Artist was successfully updated.' if @artist.update(artist_params)
    respond_with(@artist)
  end

  def destroy
    @artist.destroy
    respond_with(@artist)
  end

  private
    def set_artist
      @artist = Artist.find(params[:id])
    end

    def artist_params
      params.require(:artist).permit(:first_name, :last_name, :gender, :date_of_birth, :address, :city, :country_id, :band_name, :genre_id, :dialog, :agree_to_privacy, :subscription, :user_id,
      :user_attributes => [:username, :email, :password, :password_confirmation,:user_role, :provider, :token, :uid])
    end
end
