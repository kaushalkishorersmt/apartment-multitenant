class Category < ApplicationRecord
  belongs_to :product_segment
  has_many :subcategories
end
