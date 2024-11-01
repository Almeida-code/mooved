class AddUserIdToTrucks < ActiveRecord::Migration[7.1]
  def change
    add_column :trucks, :user_id, :integer
    add_index :trucks, :user_id
  end
end
