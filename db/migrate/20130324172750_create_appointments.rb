class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.date :apt_date
      t.time :apt_time
      t.string :location
      t.integer :order_id
      t.string :description
      t.boolean :completed_flag
      t.boolean :problem_flag

      t.timestamps
    end
  end
end
