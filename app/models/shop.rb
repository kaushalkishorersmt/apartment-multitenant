class Shop < ApplicationRecord
  belongs_to :theme
  belongs_to :main_product

  after_create :create_tenant

  has_many :shop_site_admins
  has_many :site_admin, through: :shop_site_admins

  before_save do
    self.subdomain = self.shop_name.parameterize if self.shop_name_changed?
  end

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end
end
