module ApplicationHelper
  ##TODO: form messages
  #def show_first_error(obj, form_field)
  #  arr = []
  #  obj.errors.each do |field, message|
  #    arr << message if field.to_sym == form_field
  #  end
  #  arr.empty? ? "" : ("<p class=\"mb-ui-form-field-error\">".concat(arr.first).concat("</p>")).html_safe
  #end

  def get_field_error(obj, form_field)
    arr = []
    begin
      obj.errors.each do |field, message|
        arr << message if field.to_sym == form_field
      end
    rescue
    end
    arr.size > 0 ? arr[0] : nil
  end

  def field_has_error?(obj, form_field)
    get_field_error(obj, form_field) ? true : false
  end

  def activate_option(menu_option, controller_name)
    menu = {hairstyles: "portfolio", hairstyle_collections: "portfolio", categories: "accessories", accessories: "accessories", appointments: "appointments", orders: "orders"}
    (menu.has_key?(controller_name.to_sym) and menu[controller_name.to_sym] == menu_option) ? "active" : "nine"
  end
end
