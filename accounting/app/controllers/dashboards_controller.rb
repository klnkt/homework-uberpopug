class DashboardsController
  def index
    @revenue = Task.on_date(Date.today).sum(:cost)
    @paid = AccountBalance.positive.sum(:balance)
    @profit = @revenue - @paid
  end
end
