class CreateProductSegments < ActiveRecord::Migration[5.1]
  def change
    create_table :product_segments do |t|
      t.string :title

      t.timestamps
    end
  end
end
