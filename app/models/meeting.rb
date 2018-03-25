class Meeting < ActiveRecord::Base
  attr_accessible :agenda, :ends_at, :minutes_of_meeting, :starts_at, :title, :date
  has_many :user_meeting_statuses, dependent: :destroy

  validates :title, presence: true
  validates :agenda, presence: true
  validates :date, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :duration_of_meeting

  after_create :reminder

  def reminder
  end

  def when_to_run
    Time.parse("#{date} #{starts_at} +0530") - 1.hour
  end

  handle_asynchronously :reminder, :run_at => Proc.new { |i| i.when_to_run }

  private
    def duration_of_meeting
      if Time.parse(ends_at) <= Time.parse(starts_at)
        errors[:base] << "End time cannot be lesser than Start Time. Specify a valid end time"
      end
    end

end
