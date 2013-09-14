class OrderObserver < ActiveRecord::Observer
  def after_create(order)
    OrderMailer.order_confirmation_email(order).deliver
  end
end