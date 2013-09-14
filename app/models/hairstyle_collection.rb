class HairstyleCollection < ActiveRecord::Base
  #TODO: need to add index for the intermediate table!
  has_and_belongs_to_many :hairstyles
  attr_accessible :name, :description, :collection_type
end
