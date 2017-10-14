class AddImageToGames < ActiveRecord::Migration[5.1]
  def change
    add_attachment :games, :image
  end
end
