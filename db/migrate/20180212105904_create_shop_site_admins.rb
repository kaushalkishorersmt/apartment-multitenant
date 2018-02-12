class CreateShopSiteAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :shop_site_admins do |t|
      t.integer :shop_id
      t.integer :site_admin_id

      t.timestamps
    end
  end
end
