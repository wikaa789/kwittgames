class AddUrlToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :url, :string
  end
end
