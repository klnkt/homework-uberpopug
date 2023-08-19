module Tasks
  class Create
    class << self
      def call(params)
        task = Task.find_by(public_id: params[:public_id])
        TaskAuditLog.create(
          task_public_id: params[:public_id],
          cost: task.cost || 0
        )
      end
    end
  end
end
