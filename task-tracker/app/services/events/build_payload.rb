module Events
  class BuildPayload
    def initilize(event_type, payload)
      @event_type = event_type
      @payload = payload
    end

    def build_payload
      send("#{@event_type}_payload")
    end

    private

    def task_created_payload
      {
        name: 'TaskCreated',
        data: full_task_data
      }
    end

    def task_reassigned_payload
      {
        name: 'TaskReassigned',
        data: compact_task_data
      }
    end

    def task_completed_payload
      {
        name: 'TaskCompleted',
        data: compact_task_data
      }
    end

    def full_task_data
      {
        public_id: @task.public_id,
        title: @task.title,
        description: @task.description,
        cost: @task.cost,
        reward: @task.reward,
        assignee_public_id: @task.assignee_public_id,
        status: @task.status
      }
    end

    def compact_task_data
      {
        public_id: @task.public_id,
        cost: @task.cost,
        reward: @task.reward,
        assignee_public_id: @task.assignee_public_id
      }
    end
  end
end
