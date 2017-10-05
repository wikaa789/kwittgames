class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.string :creator
      t.integer :rating
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
