class AddPercentCorrectAnswersToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :percent_correct_answers, :integer, default: 0
  end
end
