class CreateHairstyleCollections < ActiveRecord::Migration
  def change
    create_table :hairstyle_collections do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
