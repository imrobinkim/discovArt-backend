class Artwork < ApplicationRecord
  # Favorited by users
  has_many :favorite_artworks # just the 'relationships'
  has_many :favorited_by, :through => :favorite_artworks, source: :user # the actual users favoriting a recipe
end
