module ApplicationHelper
  include SendGrid

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "WCoT Dashboard"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def send_email(email_values)
    # Sample Data:
    # email_values = {
    #   'from' => 'sender@gmail.com', #optional
    #   'to' => 'reciever@gmail.com', #can be an array too: ['reciever1@gmail.com', 'reciever2@yopmail.com']
    #   'subject' => 'Sample Email',
    #   'body' => 'Test Email' #html format
    # }

    email_values['from'] = account_admin_email if email_values['from'].nil?
    raise "Subject cannot be blank" if email_values['subject'].nil?

    recipients = Array.new
    if email_values['to'].is_a? Array
      raise "Receiver emails cannot be empty" if email_values['to'].empty?
      email_values['to'].each do |email_id|
        recipients.push({ 'email': email_id })
      end
    elsif email_values['to'].is_a? String
      raise "Receiver email cannot be blank" if email_values['to'].blank?
      recipients.push({ 'email': email_values['to'] })
    else
      raise "Receiver email is not specifed" if email_values['to'].nil?
    end

    mail_data = {
      'personalizations': [{
        'to': recipients,
        'subject': email_values['subject']
      }],
      'from': {
        'email': email_values['from']
      },
      'content': [{
        'type': 'text/html',
        'value': email_values['body']
      }]
    }

    sendgrid_api = SendGrid::API.new(api_key: Rails.application.config.sendgrid_api_key)
    response = sendgrid_api.client.mail._('send').post(request_body: JSON.parse(mail_data.to_json))
    puts response.status_code
    puts response.body
    puts response.headers
  end

  def account_admin_email
    User.find_by_account_admin(true).email
  end
end
