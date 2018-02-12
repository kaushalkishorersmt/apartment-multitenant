class CreateMainProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :main_products do |t|
      t.string :title

      t.timestamps
    end
  end
end
