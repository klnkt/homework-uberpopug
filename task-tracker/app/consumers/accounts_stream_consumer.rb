class AccountsStreamConsumer < ApplicationConsumer
  def consume
    params_batch.each do |message|
      puts '-' * 80
      p message
      puts '-' * 80

      case message['event_name']
      when 'AccountCreated'
        Accounts::Create.call(message['data'])
      when 'AccountUpdated'
        Accounts::Update.call(message['data'])
      when 'AccountDeleted'
        Accounts::Delete.call(message['data'])
      when 'AccountRoleChanged'
        Accounts::UpdateRoll.call(message['data'])
      else
        # store events in DB
      end
    end
  end

  def account_repo
    Container['repositories.account']
  end
end
