module Accounts
  class UpdateRole
    class << self
      def call(params)
        account = Account.find_by(public_id: params["public_id"])
        return unless account

        account.update(role: params['role'])
      end
    end
  end
end
