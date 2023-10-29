class City < ApplicationRecord
  has_many :listenings

  validates :name, presence: true
  validates :zip_code, presence: true, uniqueness: true, format: { with: /\A\d+\z/, message: "please enter a valid zip code" }
end
