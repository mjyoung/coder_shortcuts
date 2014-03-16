class AddUserIdToShortcuts < ActiveRecord::Migration
  def change
    add_column :shortcuts, :user_id, :integer
  end
end
