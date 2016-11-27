class Site < ApplicationRecord
  belongs_to :user

  has_many :caracteristiques
  has_many :products
  has_many :categories
end
