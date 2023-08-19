class AddAssigneeToTasks < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :assignee_id
    remove_column :tasks, :account_id
    add_reference :tasks, :account, foreign_key: true
  end
end
