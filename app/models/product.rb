class Product < ApplicationRecord
  belongs_to :subcategory
  has_many :product_properties, dependent: :destroy
  accepts_nested_attributes_for :product_properties
end
