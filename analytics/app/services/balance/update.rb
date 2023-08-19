module Balance
  class Update
    class << self
      def call(params)
        account = Account.find_by(public_id: params[:assignee_public_id])
        return unless account

        account.update(balance: params[:amount])
      end
    end
  end
end
