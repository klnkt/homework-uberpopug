module Events
  class BuildPayload
    class << self
      def build_payload(event_type, payload)
        @account_balance = payload
        send("build_#{event_type}")
      end

      private

      def build_account_balance_updated
        payload = {
          event_name: 'AccountBalanceUpdated',
          data: {
            account_public_id: @account_balance.account.public_id,
            amount: @account_balance.balance
          }
        }
        {
          event_type: 'account_balance.updated',
          event_version: 1,
          payload: metadata.merge(payload)
        }
      end

      def metadata
        {
          event_id: SecureRandom.uuid,
          event_time: Time.now.to_s,
          producer: 'accounting_service '
        }
      end
    end
  end
end
