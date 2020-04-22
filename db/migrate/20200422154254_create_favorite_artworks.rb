class CreateFavoriteArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_artworks do |t|
      t.belongs_to :user
      t.belongs_to :artwork

      t.timestamps
    end
  end
end
