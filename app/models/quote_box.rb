class QuoteBox < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :order
  attr_accessible :order_id
  def add_item(item)
    if item.is_a?(Appointment) and li = line_items.find_by_quotable_type(Appointment.to_s)
      li.errors.add(:base, "you already selected an appointment")
      return li
    end
    #try to find the same class and id in the quote box
    line_items.each do |li|
      if li.quotable_type == item.class.to_s and li.quotable_id == item.id
        if item.class.to_s == "Appointment"
        end
        li.quantity += 1
        return li
      end
    end
    return line_items.build(quotable: item)
  end
end
