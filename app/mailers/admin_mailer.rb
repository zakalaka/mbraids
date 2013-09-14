class AdminMailer < ActionMailer::Base
  default from: "notification@example.com"

  def notification_email(user)
    @user = user
    mail(:to => "eugene@insydeco.com", :subject => "New user signup: #{@user.email}") do |format|
      format.html
      #format.html {render :layout => 'custom_layout'}
      format.text
      #format.text {render :text => "sample text here"}
    end
  end
end
