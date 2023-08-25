class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :type
      t.float :amount
      t.task_public_id :string
      t.status :string

      t.timestamps
    end
  end
end
