module Accounts
  class Delete
    class << self
      def call(params)
        account = Account.find_by(public_id: params[:public_id])
        next unless account

        account.destroy
      end
    end
  end
end
