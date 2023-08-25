module Events
  class BuildPayload
    class << self
      def build_payload(event_type, task)
        @task = task
        send("build_#{event_type}")
      end

      private

      def build_task_created
        payload = {
          event_name: 'TaskCreated',
          data: full_data
        }
        {
          event_type: 'tasks.created',
          event_version: 1,
          payload: metadata.merge(payload)
        }
      end

      def build_task_reassigned
        payload = {
          event_name: 'TaskReassigned',
          data: compact_data
        }
        {
          event_type: 'tasks.reassigned',
          event_version: 1,
          payload: metadata.merge(payload)
        }
      end

      def build_task_completed
        payload = {
          event_name: 'TaskCompleted',
          data: compact_data
        }
        {
          event_type: 'tasks.completed',
          event_version: 1,
          payload: metadata.merge(payload)
        }
      end

      def metadata
        {
          event_id: SecureRandom.uuid,
          event_time: Time.now.to_s,
          producer: 'task_tracker_service '
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
