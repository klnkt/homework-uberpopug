class AccountsStreamConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      puts '-' * 80
      p message
      puts '-' * 80

      begin
        payload = message.payload

        puts '-' * 80
        p payload
        puts '-' * 80

        puts
        case payload['event_name']
        when 'AccountCreated'
          Accounts::Create.call(payload['data'])
        when 'AccountUpdated'
          Accounts::Update.call(payload['data'])
        when 'AccountDeleted'
          Accounts::Delete.call(payload['data'])
        when 'AccountRoleChanged'
          Accounts::UpdateRoll.call(payload['data'])
        else
          # store events in DB
        end
      rescue
        puts '-' * 80
        p 'Failed to process the event'
        puts '-' * 80
      end
    end
  end
end
