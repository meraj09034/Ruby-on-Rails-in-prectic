class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def manage_users
  end

  def edit_user_details
    @user = User.find(params[:id])
  end

  def index
    @admins = Admin.all
    respond_with(@admins)
  end

  def show
    respond_with(@admin)
  end

  def new
    @admin = Admin.new
    respond_with(@admin)
  end

  def edit
  end

  def create
    @admin = Admin.new(admin_params)
    flash[:notice] = 'Admin was successfully created.' if @admin.save
    respond_with(@admin)
  end

  def update
    flash[:notice] = 'Admin was successfully updated.' if @admin.update(admin_params)
    respond_with(@admin)
  end

  def destroy
    @admin.destroy
    respond_with(@admin)
  end

  private
    def set_admin
      @admin = Admin.find(params[:id])
    end

    def admin_params
      params.require(:admin).permit(:first_name, :last_name, :gender, :date_of_birth, :address, :city, :country_id, :user_id)
    end
end
