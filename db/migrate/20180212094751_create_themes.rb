class CreateThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :themes do |t|
      t.string :theme_name
      t.text :description
      t.boolean :is_active

      t.timestamps
    end
  end
end
