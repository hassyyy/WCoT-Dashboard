class UsersController < ApplicationController

  before_filter :requires_login
  before_filter :has_access,   only: [:edit, :update]
  before_filter :should_be_account_admin,     only: [:new, :create, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # sign_in @user
      # flash[:success] = "Welcome to the WCoT Dashboard!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @previous_contributions = @user.contributions.where("month != ? or year != ?", Date.today.strftime("%b"), Date.today.strftime("%Y")).paginate(page: params[:page], :per_page => 10)
    @new_contribution = current_user.contributions.build
  end

  def edit
    unless request.referrer.nil?
      store_location(request.referrer) if request.referrer.end_with? users_path
    end
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user if current_user == @user
      redirect_back_or @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.order(:id).paginate(page: params[:page], :per_page => 15)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    UNAUTHORIZED_MESSAGE = "You are not authorized to access this page. Kindly contact your account admin."

    def has_access
      @user = User.find(params[:id])
      redirect_to(root_url, notice: UNAUTHORIZED_MESSAGE) unless current_user?(@user) || current_user.account_admin?
    end

    def should_be_account_admin
      redirect_to(root_url, notice: UNAUTHORIZED_MESSAGE) unless current_user.account_admin?
    end

end
