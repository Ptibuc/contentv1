class Categorie < ApplicationRecord
  belongs_to :site

  has_many :products, through: :has_categories
end
