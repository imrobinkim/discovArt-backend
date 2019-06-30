class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :creator
      t.string :dimensions
      t.string :medium
      t.string :date_text
      t.string :display_location
      t.string :geography

      t.timestamps
    end
  end
end
