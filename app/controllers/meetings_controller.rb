class MeetingsController < ApplicationController
  include MeetingsHelper
  include SessionsHelper

  before_filter :requires_login

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(params[:meeting])
    if @meeting.save
      invite_contributors(@meeting)
      flash[:success] = "Meeting is successfully created and invitation emails are sent to contributors."
      redirect_to @meeting
    else
      render 'new'
    end
  end

  def destroy
    Meeting.find(params[:id]).destroy
    flash[:success] = "Meeting is successfully deleted."
    redirect_to meetings_url
  end

  def index
    @meetings = Meeting.order(:id).reverse_order.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @meeting = Meeting.find(params[:id])
    @user_statuses = @meeting.user_meeting_statuses
    @current_user_status = UserMeetingStatus.where(:user_id => current_user.id).where(:meeting_id => params[:id]).first unless current_user.account_admin?
  end

  def edit
    unless request.referrer.nil?
      store_location(request.referrer) if request.referrer.end_with? meetings_path
    end
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update_attributes(params[:meeting])
      flash[:success] = "Meeting updated!"
      redirect_back_or @meeting
    else
      render 'edit'
    end
  end

  def update_mom
    @meeting = Meeting.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

end
