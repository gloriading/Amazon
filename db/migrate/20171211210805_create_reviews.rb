class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :body
      t.references :product, foreign_key: true, index:true

      t.timestamps
    end
  end
end
