class CreateFavourites < ActiveRecord::Migration[5.1]
  def change
    create_table :favourites do |t|
      t.references :product, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
