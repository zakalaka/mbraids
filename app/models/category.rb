class Category < ActiveRecord::Base
  #TODO: need to add index for the intermediate table!
  has_and_belongs_to_many :accessories
  attr_accessible :name, :description
  validates_presence_of :name, :description
  validates_length_of :name, :minimum => 7
end
