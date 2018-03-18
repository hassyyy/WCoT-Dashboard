class UserMeetingStatusesController < ApplicationController

  def update
    @current_user_status = UserMeetingStatus.find(params[:id])

    flash[:success] = "Status updated!" if @current_user_status.update_attributes(params[:user_meeting_status])

    redirect_to @current_user_status.meeting
  end

end
