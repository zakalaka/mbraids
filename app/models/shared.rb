module Shared
  def ensure_not_referenced
    if line_items.empty?
      begin
        Dir["#{Rails.root.join('app','assets','uploads',self.image.split('_',2)[0])}*"].each do |match|
          File.delete(Rails.root.join('app','assets','uploads',match))
        #File.delete(Rails.root.join('app','assets','uploads',self.image.sub(/_120/,'_orig')))
        end
      rescue
      end
      true
    else
      #TODO: modify this below
      errors.add(:base, '.common.messages.hairstyle.line_items_present')
      #false
    end
  end
  def clear_image
    begin
      logger.debug(">>>> clearing: #{@existing_image_name}")
      Dir["#{Rails.root.join('app','assets','uploads', @existing_image_name.split('_',2)[0])}*"].each do |match|
        File.delete(Rails.root.join('app','assets','uploads',match))
      #File.delete(Rails.root.join('app','assets','uploads',self.image.sub(/_120/,'_orig')))
      end
    rescue
    end
      #true
  end

  def get_random_5
    (0...5).map{ ('a'..'z').to_a[rand(26)] }.join
  end

  def get_random_8
    (0...8).map{ ('a'..'z').to_a[rand(26)] }.join
  end

  #def store_image(_image)
  #  #image data comes as a object in the param image
  #  image_data = _image
  #  if image_data && image_data.original_filename =~ /^image/
  #    img = File.basename(image_data.original_filename).gsub(/[^\w._-]/, '')
  #    #img = image_data.original_filename.split('.')[0] + "_#{get_random_suffix}." + original_filename.split('.')[1]
  #
  #    File.open(Rails.root.join('app','assets','uploads',img),'wb') do |file|
  #      file.write(image_data.read)
  #    end
  #  else
  #    raise StandardError, "can't do this"
  #  end
  #end
  def save_image(image_data,*dimensions)
    image_extension = File.basename(image_data.original_filename).reverse.split('.',2)[0].reverse
    random_chars = get_random_8
    new_name = "#{random_chars}_orig.#{image_extension}"
    File.open(Rails.root.join('app','assets','uploads',new_name),'wb') do |file|
      #begin
        file.write(image_data.read)
        table_name_set = false
        dimensions.each do |dimension|
          new_transformed_name = "#{random_chars}_#{dimension.to_s}.#{image_extension}"
          unless table_name_set
            table_name_set = true
            self.image = new_transformed_name
          end
          image_transform_params = []
          image_transform_params << Rails.root.join('app','assets','uploads',new_name)
          image_transform_params << "-resize #{dimension}x#{dimension} #{Rails.root.join('app','assets','uploads',new_transformed_name)}"
          #TODO: this relies on existence of simple_captcha plugin
          SimpleCaptcha::Utils::run("convert", image_transform_params.join(' '))
        end
      #rescue
      #  raise StandardError, "Unable to save image in the filesystem"
      #end
    end
  end
end