class LineItem < ActiveRecord::Base
  belongs_to :quotable, :polymorphic => true
  belongs_to :quote_box
  attr_protected

end