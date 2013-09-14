class RenameAccountsFrozenColumn < ActiveRecord::Migration
  def up
    remove_column :accounts, :frozen
    add_column :accounts, :frozen_flag, :boolean, :default => false
    remove_column :accounts, :type
    add_column :accounts, :account_type, :string, :limit => 3
  end
  def down
    remove_column :accounts, :frozen_flag
    add_column :accounts, :frozen, :boolean, :default => false
    remove_column :accounts, :account_type
    add_column :accounts, :type, :string, :limit => 3
  end
end
