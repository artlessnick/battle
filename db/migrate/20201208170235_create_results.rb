class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.string :category
      t.integer :quentity_questions
      t.integer :correct_answers, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
