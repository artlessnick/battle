class CreateRoundAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :round_answers do |t|
      t.string :answer1
      t.integer :question1_id
      t.string :answer2
      t.integer :question2_id
      t.string :answer3
      t.integer :question3_id
      t.references :round, null: false, foreign_key: true

      t.timestamps
    end
  end
end
