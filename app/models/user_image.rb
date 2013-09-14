class UserImage < ActiveRecord::Base
  #belongs_to :user
  belongs_to :order
  attr_accessible :image, :user_id
end
