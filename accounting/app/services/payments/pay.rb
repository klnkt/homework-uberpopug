module Payments
  class Pay
    class << self
      def call(transaction)
        transaction.update(status: 'Completed')
      end
    end
  end
end
