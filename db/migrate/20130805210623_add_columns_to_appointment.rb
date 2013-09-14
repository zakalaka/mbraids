class AddColumnsToAppointment < ActiveRecord::Migration
  def up
    add_column :appointments, :booked_flag, :boolean, :default => 0
    add_column :appointments, :identifier, :string, :limit => 6
    add_column :appointments, :duration, :decimal, :precision => 3, :scale => 0
    remove_column :appointments, :order_id
  end

  def down
    remove_column :appointments, :booked_flag
    remove_column :appointments, :identifier
    remove_column :appointments, :duration
    add_column :appointments, :order_id, :integer
  end
end
