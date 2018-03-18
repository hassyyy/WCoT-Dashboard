module UsersHelper
  include ApplicationHelper

  def send_welcome_email(user)
    email_values = {
      'to' => user.email,
      'subject' => "Welcome to WCoT!",
      'body' => welcome_email_body(user)
    }

    send_email(email_values)
  end

  def welcome_email_body(user)
    "<html>
      <body>
        A new account has been created for you in WCoT Dashboard <br>
        <br>
        Click <a href=\"#{request.original_url}\">here</a> to login with following credentials <br>
        <br>
        <strong>Email:</strong> #{user.email} <br>
        <strong>Phone Number:</strong> #{user.phone} <br>
        <strong>Password:</strong> #{user.password} <br>
      </body>
    </html>"
  end

end
