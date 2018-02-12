class Shop < ApplicationRecord
  belongs_to :theme
  belongs_to :main_product

  before_save do
    self.subdomain = self.shop_name.parameterize if self.shop_name_changed?
  end
end
