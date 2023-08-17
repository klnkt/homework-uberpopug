module Accounts
  class Update
    class << self
      def call(params)
        account = Account.find_by(public_id: params[:public_id])
        next unless account

        account.update(params)
      end
    end
  end
end
