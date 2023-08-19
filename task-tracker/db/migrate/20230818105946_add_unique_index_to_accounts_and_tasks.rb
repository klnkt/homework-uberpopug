class AddUniqueIndexToAccountsAndTasks < ActiveRecord::Migration[7.0]
  def change
    add_index :accounts, :public_id, unique: true

    add_index :tasks, :public_id, unique: true

    add_column :tasks, :account_id, :string
  end
end
