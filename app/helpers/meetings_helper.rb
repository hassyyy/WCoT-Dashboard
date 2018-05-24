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

  def update_contributors(meeting)
    changed_attributes = meeting.previous_changes
    return if changed_attributes.empty?
    if !changed_attributes.except('updated_at', 'title', 'minutes_of_meeting').empty?
      User.all.each do |user|
        next if user.account_admin?
        send_update_notification(user.email, meeting, changed_attributes.except('updated_at', 'title', 'minutes_of_meeting'))
      end
      flash[:success] = "Meeting is successfully updated and notification emails are sent to contributors"
    elsif changed_attributes.has_key?('minutes_of_meeting')
      flash[:success] = "Minutes of Meeting is successfully updated!"
    end
  end

  def send_update_notification(to, meeting, changed_attributes)
    email_values = {
      'to' => to,
      'subject' => "WCoT Meeting Update Notification: #{meeting.title} - #{meeting.date}",
      'body' => update_notification_email_body(meeting).gsub('changed_attributes_replace', construct_changes(changed_attributes))
    }

    send_email(email_values)
  end

  def update_notification_email_body(meeting)
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
        td, th{
          padding: 10px 10px 10px 10px;
          align: center;
        }
      </style>
    </head>
    <body>
      Following changes have been made: <br>
      <table>
        <tr>
          <th>Changed Attribute</th>
          <th>Previously</th>
          <th>Now</th>
        </tr>
        changed_attributes_replace
      </table>

      Click <a href=\"#{request.original_url}\">here</a> to update your status.

    </body>
    </html>"
  end

  def construct_changes(changed_attributes)
    constructed_text = String.new
    changed_attributes.each do |attribute, values|
      constructed_text << "<tr>"
      constructed_text << "<td>#{attribute.titlecase}</td><td>#{values.first}</td><td>#{values.last}</td>"
      constructed_text << "</tr>"
    end
    return constructed_text
  end
end
