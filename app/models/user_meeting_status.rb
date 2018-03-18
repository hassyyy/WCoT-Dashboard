class UserMeetingStatus < ActiveRecord::Base
  attr_accessible :meeting_id, :status, :user_id
  belongs_to :user
  belongs_to :meeting
end
