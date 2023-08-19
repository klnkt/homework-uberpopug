module Accounts
  class Create
    class << self
      def call(params)
        account = Account.find_by(public_id: params[:assignee_public_id])
        return unless account

        balance = account.balance.first_or_create
        transaction = balance.transactions.create(
          amount: params[:reward],
          task_id: params[:public_id],
          status: 'New'
        )
      end
    end
  end
end
