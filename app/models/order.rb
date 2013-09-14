class Order < ActiveRecord::Base
  has_one :quote_box
  has_one :order_image, :class_name => UserImage, :foreign_key => :user_id
  attr_accessible :user_id
  validate :appointment_availability
  after_create :reserve_appointment, if: :appointment_in_quote_box

  private

  def appointment_availability
      errors.add(:base, "the appointment you have chosen is already booked by another user") if appointment_in_quote_box and Appointment.find(quote_box.line_items.first(conditions: "quotable_type = 'Appointment'").quotable_id).booked_flag
  end

  def reserve_appointment
      Appointment.find(quote_box.line_items.first(conditions: "quotable_type = 'Appointment'").quotable_id).update_attribute(:booked_flag, true)
  end

  def appointment_in_quote_box
    if quote_box.line_items.first(conditions: "quotable_type = 'Appointment'")
      true
    else
      false
    end
  end
end
