class Meeting < ActiveRecord::Base
  include ApplicationHelper
  attr_accessible :agenda, :ends_at, :minutes_of_meeting, :starts_at, :title, :date
  has_many :user_meeting_statuses, dependent: :destroy

  validates :title, presence: true
  validates :agenda, presence: true
  validates :date, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :duration_of_meeting

  after_commit  ->(obj) { obj.reminder } , on: :create
  after_commit  ->(obj) { obj.reminder } , on: :update
  after_commit :get_queue_name, on: :destroy

  def reminder
    return if (Time.parse("#{date} #{starts_at} +0530") - 15.minutes) <= Time.now.getlocal("+05:30") 
    attending_user_emails = attending_users
    return if attending_user_emails.empty?
    
    email_values = {
      'to' => attending_user_emails,
      'subject' => "WCoT Meeting Reminder: Today at #{starts_at}",
      'body' => reminder_email_body
    }
    send_email(email_values)
  end

  def attending_users
    attending_user_emails = Array.new
    user_meeting_statuses.each do |user_status|
      attending_user_emails << user_status.user.email if user_status.status == "Accepted" || user_status.status == "Tentative"
    end
    return attending_user_emails
  end

  def when_to_run
    Time.parse("#{date} #{starts_at} +0530") - 1.hour
  end

  def get_queue_name
    queue_name = "meeting#{id}"
    delete_existing_jobs(queue_name)
    return queue_name
  end

  def delete_existing_jobs(queue_name)
    Delayed::Job.find_all_by_queue(queue_name).each do |job|
      job.delete
    end
  end

  handle_asynchronously :reminder, :run_at => Proc.new { |i| i.when_to_run }, :queue => Proc.new { |i| i.get_queue_name }

  def reminder_email_body
    "<html>
    <head>
      <style>
        table, th, td {
          border: 1px solid black;
        }
        table{
          margin-top: 10px;
          margin-bottom: 10px;
          border-collapse: collapse;
        }
        td{
          padding: 10px 10px 10px 10px;
        }
      </style>
    </head>
    <body>
      You have been invited to attend the following meeting today: <br>
      <table>
        <tr>
          <td>
            <center> <strong> #{title} </strong> </center> <br>
             #{date} (Today) <strong> | </strong>
            <em> #{starts_at} - #{ends_at}  </em>
          </td>
          <td>
            <center> <strong> Agenda </strong> </center> <br>
            #{agenda}
          </td>
        </tr>
      </table>
    </body>
    </html>"
  end

  private
  def duration_of_meeting
    if Time.parse("#{date} #{starts_at} +0530") <= Time.now.getlocal("+05:30") && minutes_of_meeting.nil?
      errors[:base] << "Start time cannot be lesser than current time. Specify a valid start time"
    end
    if Time.parse(ends_at) <= Time.parse(starts_at)
      errors[:base] << "End time cannot be lesser than Start Time. Specify a valid end time"
    end
  end

end
