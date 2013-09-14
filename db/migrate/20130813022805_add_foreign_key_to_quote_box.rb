class AddForeignKeyToQuoteBox < ActiveRecord::Migration
  def change
    add_column :quote_boxes, :order_id, :integer

  end
end
