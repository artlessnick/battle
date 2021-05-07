class AddCountinRounds < ActiveRecord::Migration[6.0]
  def change
    add_column :rounds, :count_questions, :integer
  end
end
