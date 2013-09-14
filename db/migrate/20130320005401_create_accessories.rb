class CreateAccessories < ActiveRecord::Migration
  def change
    create_table :accessories do |t|
      t.string :image
      t.string :name
      t.string :description
      t.decimal :price, :precision => 5, :scale => 2, :default => 0
      t.boolean :displayable_flag, :default => true
      t.timestamps
    end
  end
end
