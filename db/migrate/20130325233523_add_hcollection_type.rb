class AddHcollectionType < ActiveRecord::Migration
  def up
    add_column :hairstyle_collections, :collection_type, :string, :limit => 1
    add_column :hairstyle_collections, :displayable_flag, :boolean, :default => true
  end

  def down
    remove_column :hairstyle_collections, :collection_type
    remove_column :hairstyle_collections, :displayable_flag
  end
end