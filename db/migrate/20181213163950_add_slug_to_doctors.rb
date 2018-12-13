class AddSlugToDoctors < ActiveRecord::Migration[5.1]
  def change
    add_column :doctors, :slug, :string
    add_index :doctors, :slug, unique: true
  end
end
