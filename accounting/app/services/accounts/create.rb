module Accounts
  class Create
    class << self
      def call(params)
        account = Account.new(params)
        account.save!
      end
    end
  end
end
