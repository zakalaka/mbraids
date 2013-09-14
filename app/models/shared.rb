module Shared
  def ensure_not_referenced
    if line_items.empty?
      true
    else
      #TODO: modify this below
      errors.add(:base, 'line_items_present')
      false
    end
  end
end