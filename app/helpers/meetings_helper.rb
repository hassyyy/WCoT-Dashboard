module MeetingsHelper
  include ApplicationHelper

  def invite_contributors(meeting)
    User.all.each do |user|
      next if user.account_admin?
      send_invitation_email(user.email, meeting)
      UserMeetingStatus.create(user_id: user.id, meeting_id: meeting.id, status: "Invited")
    end
  end

  def send_invitation_email(to, meeting)
    email_values = {
      'to' => to,
      'subject' => "WCoT Meeting Invitation: #{meeting.title} - #{meeting.date}",
      'body' => invitation_email_body(meeting)
    }

    send_email(email_values)
  end

  def invitation_email_body(meeting)
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
      You have been invited to attend the following meeting: <br>
      <table>
        <tr>
          <td>
            <center> <strong> #{meeting.title} </strong> </center> <br>
             #{meeting.date} (#{Time.parse(meeting.date).strftime("%A")}) <strong> | </strong>
            <em> #{meeting.starts_at} - #{meeting.ends_at}  </em>
          </td>
          <td>
            <center> <strong> Agenda </strong> </center> <br>
            #{meeting.agenda}
          </td>
        </tr>
      </table>

      Click <a href=\"#{request.original_url}/#{meeting.id}\">here</a> to update your status.

    </body>
    </html>"
  end
end
