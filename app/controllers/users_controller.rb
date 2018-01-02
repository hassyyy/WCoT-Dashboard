class UsersController < ApplicationController

  before_filter :requires_login, only: [:index, :edit, :update, :destroy]
  before_filter :has_access,   only: [:edit, :update]
  before_filter :should_be_account_admin,     only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the WCoT Dashboard!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user if current_user == @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page], :per_page => 15)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def requires_login
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def has_access
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.account_admin?
    end

    def should_be_account_admin
      redirect_to(root_url) unless current_user.account_admin?
    end

end
