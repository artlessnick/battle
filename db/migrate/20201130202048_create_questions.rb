class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :category
      t.string :question
      t.string :trueanswer
      t.string :answer1
      t.string :answer2
      t.string :answer3
      t.string :answer4

      t.timestamps
    end
  end
end
