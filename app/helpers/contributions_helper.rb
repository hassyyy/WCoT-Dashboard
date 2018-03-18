module ContributionsHelper
  include ApplicationHelper

  def send_received_email(contribution)
    email_values = {
      'to' => contribution.user.email,
      'subject' => "WCoT : Thanks for your contribution!",
      'body' => contribution_email_body(contribution)
    }

    send_email(email_values)
  end

  def contribution_email_body(contribution)
    "<html>
      <body>
        We have received your contribution of <strong>Rs.#{contribution.value}</strong> for <em>#{contribution.month} #{contribution.year}</em><br>
        <br>
        Thanks for your valuable contribution! <br>
        <br>
        Your total contributions to WCoT is Rs.#{contribution.user.contributions.where(:status => "sent").sum(:value)}
      </body>
    </html>"
  end
end
