require 'shared'
class Hairstyle < ActiveRecord::Base
  include Shared
  has_and_belongs_to_many :hairstyle_collections
  has_many :line_items, :as => :quotable
  attr_accessible :image, :price, :displayable_flag, :name, :description
  validates_presence_of :name

  before_destroy :ensure_not_referenced

  private :ensure_not_referenced
end
