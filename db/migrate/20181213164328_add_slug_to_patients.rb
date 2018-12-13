class AddSlugToPatients < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :slug, :string
    add_index :patients, :slug, unique: true
  end
end
