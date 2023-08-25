module AccountBalance
  class Update
    class << self
      def call(params)
        account = Account.find_by(public_id: params[:assignee_public_id])
        return unless account

        balance = account.balance.first_or_create
        balance.transactions.create(
          amount: params[:reward],
          task_id: params[:public_id],
          status: 'New'
        )
        balance.update(balance: balance.balance + params[:reward])

        Events::ProduceEvent.call(
          topics: ['balance-stream'],
          payload: Events::BuildPayload.build_payload(:account_balance_updated, balance.reload)
        )
      end
    end
  end
end
