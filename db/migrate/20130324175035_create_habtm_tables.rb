class CreateHabtmTables < ActiveRecord::Migration
  def change
    create_table :hairstyle_collections_hairstyles, :id => false do |t|
      t.integer :hairstyle_collection_id
      t.integer :hairstyle_id
    end
    create_table :accessories_categories, :id => false do |t|
      t.integer :accessory_id
      t.integer :category_id
    end
  end
end
