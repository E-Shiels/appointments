class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.string :date
      t.text :description

      t.timestamps
    end
  end
end
