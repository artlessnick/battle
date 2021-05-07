class AddColumnAllGameInUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :allgame, :integer, default: 0
  end
end
