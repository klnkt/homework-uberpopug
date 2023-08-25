module Tasks
  class Create
    class << self
      def call(params)
        task = Task.new(params)
        task.save!
      end
    end
  end
end
