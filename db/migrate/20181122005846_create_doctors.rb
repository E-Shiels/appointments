class CreateDoctors < ActiveRecord::Migration[5.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :gender
      t.string :specialty
      t.string :practice_name
      t.string :practice_location
      t.string :phone
      t.string :email
      t.string :password_digest
      
      t.timestamps
    end
  end
end
