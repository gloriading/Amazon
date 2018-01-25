class CreateFaqs < ActiveRecord::Migration[5.1]
  def change
    create_table :faqs do |t|
      t.string :question
      t.string :answer
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
