class AddTimeToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :time, :string
  end
end
