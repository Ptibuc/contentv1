class Product < ApplicationRecord
  belongs_to :site

  has_many :caracteristiques, through: :has_caracteristiques
  has_many :categories, through: :has_categories
end
