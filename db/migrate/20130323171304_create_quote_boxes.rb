class CreateQuoteBoxes < ActiveRecord::Migration
  def change
    create_table :quote_boxes do |t|
      t.integer :appointment_id

      t.timestamps
    end
  end
end
