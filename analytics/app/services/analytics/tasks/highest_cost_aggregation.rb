module Analytics
  module Task
    class HighestCostAggregations
      class << self
        def call
          # TODO: make sure it works + ensure proper keys
          TaskCompletion.where('created_at > ?', 1.month.ago).group_by_day(:created_at).maximum(:cost)
        end
      end
    end
  end
end
