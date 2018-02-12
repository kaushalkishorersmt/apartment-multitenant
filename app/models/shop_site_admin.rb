class ShopSiteAdmin < ApplicationRecord
  belongs_to :shop
  belongs_to :site_admin
end
