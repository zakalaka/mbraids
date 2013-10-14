require 'shared'
class Hairstyle < ActiveRecord::Base
  include Shared
  #attr_accessor :image
  attr_accessible :price, :displayable_flag, :name, :description, :image_file
  def image_file=(image_data)
    @existing_image_name = self.image
    #new_name_array = File.basename(image_data.original_filename).gsub(/[^\w._-]/, '').reverse.split('.',2).reverse




    #new_name = new_name_array[0].reverse + get_random_5 + "_orig." + new_name_array[1].reverse
    #new_transformed_name = new_name_array[0].reverse + get_random_5 + "_120." + new_name_array[1].reverse
    #
    #





    #logger.debug(">>>>>>" + image_data.original_filename.inspect + "<<<<")
    #self.image = new_transformed_name

    #store_image(_image)
    if image_data.content_type.chomp =~ /^image/
      #img = File.basename(image_data.original_filename).gsub(/[^\w._-]/, '')
      #img = image_data.original_filename.split('.')[0] + "_#{get_random_suffix}." + original_filename.split('.')[1]
      #new_name = self.image.map do |name|
      #  name.reverse.split('.',2).reverse
      #end
      begin
        save_image(image_data, 320, 120)
      rescue
        #errors.add(:base, '.common.messages.hairstyle.unable_to_save_file')
        @format_error = '.common.messages.hairstyle.unable_to_save_file'
        logger.debug("<<<>>>>")
      end
    else
      #raise StandardError, "Unable to save image in the filesystem"
      #errors.add(:base, '.common.messages.hairstyle.wrong_filetype')
      @format_error = '.common.messages.hairstyle.wrong_filetype'
    end
    #  File.open(Rails.root.join('app','assets','uploads',new_name),'wb') do |file|
    #    file.write(image_data.read)
    #  end
    #else
    #  raise StandardError, "Unable to save image in the filesystem"
    #end
  end

  def file_type
    unless @format_error.nil?
      errors.add(:base, @format_error)
    end
  end

  has_and_belongs_to_many :hairstyle_collections
  has_many :line_items, :as => :quotable
  #validates_presence_of :name
  validates_numericality_of :price
  before_destroy :ensure_not_referenced
  after_update :clear_image
  validates_presence_of :name, :image
  validate :file_type

  private :ensure_not_referenced, :file_type
end
