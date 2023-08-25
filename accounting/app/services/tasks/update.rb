module Tasks
  class Update
    class << self
      def call(params)
        task = Task.find_by(public_id: params[:public_id])
        return unless task

        task.update(params)
      end
    end
  end
end
