class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string :shop_name,          null: false
      t.string :subdomain,          null: false
      t.string :domain
      t.references :theme, foreign_key: true
      t.references :main_product, foreign_key: true

      t.timestamps
    end
    add_index :shops, :subdomain, unique: true
  end
end
