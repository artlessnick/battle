class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.integer :num_round
      t.integer :roundscore, default: 0
      t.references :gamescore, null: false, foreign_key: true

      t.timestamps
    end
  end
end
