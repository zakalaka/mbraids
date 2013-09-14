class OrderMailer < ActionMailer::Base
  default from: 'Mbraids.com <nr@mbraids.com>'
  def order_confirmation_email(order)
    @order = order
    mail(to: get_user_email(order),
         bcc: %w{nr@mbraids.com admin@mbraids.com},
         subject: "Thanks for your order")
    #body {:user => usr, :url => "http://mbraids.com/login"}
  end

  private

  def get_user_email(order)
    begin
      User.find(order.user_id).email
    rescue
      "test@email.com"
    end
  end
end
