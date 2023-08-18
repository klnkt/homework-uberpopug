module Accounts
  class Delete
    class << self
      def call(params)
        account = Account.find_by(public_id: params["public_id"])
        return unless account

        account.destroy
      end
    end
  end
end
