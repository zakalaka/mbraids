class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.boolean :complete_flag
      t.boolean :problem_flag
      t.text :comments

      t.timestamps
    end
  end
end
