class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name, :limit => 30
      t.string :type, :limit => 3
      t.decimal :balance, :precision => 11, :scale => 2, :default => 0
      t.boolean :frozen, :default => false
      t.timestamps
    end
  end
end
