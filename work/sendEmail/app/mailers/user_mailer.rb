class UserMailer < ActionMailer::Base
  default from: "noor09034@gmail.com"


  def signup_confirmation(user)
    @user=user
    mail to: user.email, subject: "Email confirmation Letter"
  end
end
