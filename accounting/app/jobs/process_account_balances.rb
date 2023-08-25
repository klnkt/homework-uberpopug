class ProcessAccountBalances < ApplicationJob
  # TODO: schedule to run daily at 00:00
  def perform
    AccountBalance.positive.each do |account|
      Payments::Pay.call(account, account.balance)
      account.balance.transactions.each { |transaction| transaction.update(status: 'Completed') }
      account.balance.update(balance: 0)
    end
  end
end
