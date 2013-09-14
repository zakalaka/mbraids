class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :quote_box_id
      t.integer :quantity, default: 1
      t.references :quotable, :polymorphic => true

      t.timestamps
    end
  end
end
