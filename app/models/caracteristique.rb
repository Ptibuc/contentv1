class Caracteristique < ApplicationRecord
  belongs_to :site

  has_many :products, through: :has_caracteristiques
  has_many :phrases
end
