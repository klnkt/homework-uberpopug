class CreateTaskAuditLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :task_audit_logs do |t|
      t.task_public_id :string
      t.cost :integer

      t.timestamps
    end
  end
end
