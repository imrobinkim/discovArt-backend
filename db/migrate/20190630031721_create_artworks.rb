class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :people, array: true, default: []
      t.string :dated
      t.string :classification
      t.string :primaryimageurl

      t.timestamps
    end
  end
end
