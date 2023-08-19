class DashboardsController
  def index
    revenue = Task.on_date(Date.today).sum(:cost)
    paid = AccountBalance.positive.sum(:balance)
    @profit = revenue - paid

    @parrots_negative = Account.employees.with_negative_balance.count

    @highest_cost_aggregations = Analytics::Task::HighestCostAggregations.call
  end
end
