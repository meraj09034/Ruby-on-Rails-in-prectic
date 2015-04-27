class ExecutivesController < ApplicationController
  before_action :set_executive, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user! , only: [:new, :create, :is_email_exist]
  load_and_authorize_resource :only => [:index, :show, :new, :edit, :create, :update, :destroy]


  respond_to :html

  def index
    @executives = Executive.all
    respond_with(@executives)
  end

  def show
    respond_with(@executive)
  end

  def new
    @executive = Executive.new
    @executive.build_user
    @executive.executive_genres.build
    session["user_role"] = params[:controller]
    @fb_user = session["devise.facebook_data"] unless session["devise.facebook_data"].nil?
    unless @fb_user.nil?
      # raise @fb_user.inspect
      @executive.first_name = @fb_user['info']['first_name']
      @executive.last_name = @fb_user['info']['last_name']
      @executive.date_of_birth = @fb_user['extra']['raw_info']["birthday"]
      @executive.gender = @fb_user['extra']['raw_info']['gender']
      @executive.user.username = @fb_user['extra']['raw_info']['id']
      @executive.user.email = @fb_user['info']['email']
      @executive.user.provider = @fb_user['provider']
      @executive.user.uid = @fb_user['uid']
      @executive.user.password = @executive.user.password_confirmation = Devise.friendly_token[0,20]
    end
    respond_with(@executive)
  end

  def edit
    # raise @executive.inspect
  end

  def create
    @executive = Executive.new(executive_params)
    @executive.user.user_role = params[:controller]
    if @executive.save
      flash[:notice] = "#{t('devise.registrations.signed_up')}"
      # flash[:notice] = "#{t('devise.confirmations.send_instructions')}"
      redirect_to root_path
    else
      respond_with(@executive)
    end
  end

  def is_email_exist
    @role_type = params[:controller].singularize.to_sym
    @user = User.is_email_exist(params[@role_type][:user_attributes][:email],current_user)
  end

  def update
    flash[:notice] = 'Executive was successfully updated.' if @executive.update(executive_params)
    respond_with(@executive)
  end

  def destroy
    @executive.destroy
    respond_with(@executive)
  end

  private
    def set_executive
      @executive = Executive.find(params[:id])
    end

    def executive_params
      params.require(:executive).permit(:first_name, :last_name, :gender, :date_of_birth, :address, :city, :country_id,
                                        :website, :agree_to_privacy, :subscription, :user_id,
                                        :user_attributes => [:username, :email, :password, :password_confirmation,:user_role, :provider, :uid],
                                        :genre_ids => [])
    end
end
