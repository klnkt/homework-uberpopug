class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.public_id :string
      t.jira_id :string
      t.title :string
      t.description :string
      t.cost :integer
      t.reward :integer

      t.assignee_public_id :string

      t.timestamps
    end

    add_index :tasks, :public_id, unique: true
    add_foreign_key :tasks, :accounts, column: :assignee_public_id, primary_key: :public_id
  end
end
