class StandardFormBuilder < ActionView::Helpers::FormBuilder
  #TODO: form builder
  include ApplicationHelper
  def self.create_control(method_name)
    define_method(method_name) do |label, *args|
      options = args.extract_options!
      case method_name
        when "text_field", "password_field"
          custom_label = options[:label] || I18n.translate(".#{label.to_s}")
          custom_label_class = options[:label_class] || 'mb-ui-form-text-label'
          custom_field_class = 'mb-ui-form-text-padding ui-widget ui-state-default ui-corner-all'
          custom_field_maxlength = options[:max] || '99'
          # this should be styled from CSS instead
          #custom_field_size = options[:size] || '30'
          options.merge!(:class => custom_field_class)
          options.merge!(:maxlength => custom_field_maxlength)
          #options.merge!(:size => custom_field_size)
          @template.content_tag('div',
                                @template.content_tag('label',
                                custom_label,
                                :for => "#{@object_name}_#{label}",
                                :class => custom_label_class) +
                                super(label, *(args << options)) +
                                show_first_error(@object,label), :class => 'field')
        when "text_area"
          custom_label = options[:label] || I18n.translate(".#{label.to_s}")
          custom_label_class = options[:label_class] || 'mb-ui-form-text-label'
          custom_textarea_class = 'mb-ui-form-text-padding ui-widget ui-state-default ui-corner-all'
          # this should be styled from CSS instead
          #custom_textarea_rows_cols = options[:size] || '5x5'
          options.merge!(:class => custom_textarea_class)
          #options.merge!(:size => custom_textarea_rows_cols)
          @template.content_tag('div',
                                @template.content_tag('label',
                                custom_label,
                                :for => "#{@object_name}_#{label}",
                                :class => custom_label_class) +
                                super(label, *(args << options)) +
                                show_first_error(@object,label), :class => 'field')
          #<input id="account_frozen_flag" name="account[frozen_flag]" type="checkbox" value="1" /><label for="check">Remember me</label>
        when "check_box"
          custom_label = options[:label] || I18n.translate(".#{label.to_s}")
          custom_label_class = options[:label_class] || ''
          options.merge!(:id => 'check')
          @template.content_tag('div',
                                super(label, *(args << options)) +
                                @template.content_tag('label',
                                                      custom_label,
                                                      :for => 'check'), :class => 'field')
        when "radio_button"
          custom_label = options[:text] || I18n.translate(".#{label.to_s}")
          super(label, *args) + @template.content_tag('label',custom_label, :for => "#{@object_name}_#{label}_#{args[0]}")
        when "collection_select"
          custom_label = options[:label] || I18n.translate(".#{label.to_s}")
          custom_label_class = options[:label_class] || 'mb-ui-form-text-label'
          @template.content_tag('div',
                                super(label, *(args << options)) +
                                show_first_error(@object,label), :class => 'ui-widget')
          #@template.content_tag('div',
          #                      @template.content_tag('label',
          #                      custom_label,
          #                      :for => "#{@object_name}_#{label}",
          #                      :class => custom_label_class) +
          #                      super(label, *(args << options)) +
          #                      show_first_error(@object,label), :class => 'ui-widget')
        else
          super(label, *args)
      end
    end
  end

  all_helpers = field_helpers + %w{collection_select} - %w{hidden_field fields_for label}

  all_helpers.each { |name| create_control(name) }

end