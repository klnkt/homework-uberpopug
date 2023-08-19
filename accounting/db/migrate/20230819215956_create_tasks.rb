class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :public_id
      t.string :jira_id
      t.string :title
      t.string :description
      t.integer :cost
      t.integer :reward

      t.string :assignee_public_id

      t.timestamps
    end

    add_index :tasks, :public_id, unique: true
    add_foreign_key :tasks, :accounts, column: :assignee_public_id, primary_key: :public_id
  end
end
