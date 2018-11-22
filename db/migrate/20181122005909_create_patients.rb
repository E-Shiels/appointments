class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :gender
      t.string :age
      t.string :address
      t.string :phone
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
