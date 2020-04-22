class FavoriteArtwork < ApplicationRecord
  # favorite_artworks is join table for artworks and users.
  belongs_to :artwork
  belongs_to :user
end
