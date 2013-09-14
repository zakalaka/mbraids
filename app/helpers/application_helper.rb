module ApplicationHelper
  #TODO: form messages
  def show_first_error(obj, form_field)
    arr = []
    obj.errors.each do |field, message|
      arr << message if field.to_sym == form_field
    end
    return arr.empty? ? "" : ("<p class=\"mb-ui-form-field-error\">".concat(arr.first).concat("</p>")).html_safe
  end
end
