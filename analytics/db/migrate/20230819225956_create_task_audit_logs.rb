class CreateTaskAuditLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :task_audit_logs do |t|
      t.string :task_public_id
      t.integer :cost

      t.timestamps
    end
  end
end
