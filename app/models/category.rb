class Category < ActiveRecord::Base
  #TODO: need to add index for the intermediate table!
  has_and_belongs_to_many :accessories
  attr_accessible :name, :description
end
