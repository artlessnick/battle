class AddSelectedCategorysAndQuestionToGamescore < ActiveRecord::Migration[6.0]
  def change
    add_column :gamescores, :selected_categorys, :string 
    add_column :gamescores, :selected_questions, :string 
  end
end
