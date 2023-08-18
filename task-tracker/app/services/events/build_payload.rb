module Events
  class BuildPayload
    class << self
      def build_payload(event_type, task)
        @task = task
        send("#{event_type}_payload")
      end

      private

      def task_created_payload
        {
          name: 'TaskCreated',
          data: full_data
        }
      end

      def task_reassigned_payload
        {
          name: 'TaskReassigned',
          data: compact_data
        }
      end

      def task_completed_payload
        {
          name: 'TaskCompleted',
          data: compact_data
        }
      end

      def full_data
        {
          public_id: @task.public_id,
          title: @task.title,
          description: @task.description,
          cost: @task.cost,
          reward: @task.reward,
          assignee_public_id: @task.account.public_id,
          status: @task.status
        }
      end

      def compact_data
        {
          public_id: @task.public_id,
          assignee_public_id: @task.account.public_id
        }
      end
    end
  end
end
