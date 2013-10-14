require 'shared'
class Accessory < ActiveRecord::Base
  include Shared
  has_and_belongs_to_many :categories
  has_many :line_items, :as => :quotable
  attr_accessible :image, :price, :displayable_flag, :name, :description

  before_destroy :ensure_not_referenced
  validates_presence_of :name
  private :ensure_not_referenced
end
