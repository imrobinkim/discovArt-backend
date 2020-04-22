class User < ApplicationRecord
  has_many :favorite_artworks
  has_many :favorites, :through => :favorite_artworks, source: :artwork # can access artworks a user favorites via "user.favorites"
  # Notes on above: "favorite_artworks" gives us obj that looks like...
  # {
  #   "id": 6,
  #   "user_id": 1,
  #   "artwork_id": 225120
  # }
  # but this join table info isn't that useful to us. Instead, source association "favorite" returns...
  # {
  #   "id": 184140,
  #   "title": "North Fork 13",
  #   "dated": "1996",
  #   "classification": "Drawings", ...
  # }

  has_secure_password
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3,
    too_short: "password has to be at least %{count} characters long" }

  # Omits unnecessary info like password, created_at, updated_at
  # and adds in "favorites" - favorited artworks
  def self.user_info_to_send_back(user, favorites)
    favorites_ids = []
    favorites.each { |favorite_obj|
      favorites_ids << favorite_obj.id
    }

    {id: user.id, first_name: user.first_name, last_name: user.last_name, email: user.email, favorites: favorites, favorites_ids: favorites_ids}
  end
end
