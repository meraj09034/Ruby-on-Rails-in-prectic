class ExampleMailer < ApplicationMailer :: Base

  default from: "noor09034@gmail.com"

  def sample_email(user)
    @user = user
    mg_client = Mailgun::Client.new ENV['a9f30965d72221cf306d44863bc9ec70']
    message_params = {:from    => ENV['noor09034@gmail.com'],
                      :to      => @user.email,
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message ENV['meraj09034.mydomain.com'], message_params
  end
end
