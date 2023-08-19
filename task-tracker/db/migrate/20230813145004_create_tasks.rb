class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :status, default: 'New'
      t.integer :cost
      t.integer :reward
      t.string :assignee_id

      t.timestamps
    end
  end
end
