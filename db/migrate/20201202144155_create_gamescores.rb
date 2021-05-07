class CreateGamescores < ActiveRecord::Migration[6.0]
  def change
    create_table :gamescores do |t|
      t.integer :num_game
      t.integer :score_game, default: 0
      t.integer :count_round, default: 1
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
