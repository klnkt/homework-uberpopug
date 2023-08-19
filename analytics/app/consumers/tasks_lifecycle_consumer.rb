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

        result = SchemaRegistry.validate_event(payload, payload['event_type'], version: payload['event_version'])

        if result.success?
          process_acount_events(payload)
        else
          # TODO: save in the DB for later processing
          puts "Event #{payload['event_type']} is invalid: #{result.errors}"
        end
      rescue
        puts '-' * 80
        p 'Failed to process the event'
        puts '-' * 80
      end
    end
  end

  private

  def process_acount_events(payload)
    if payload['event_name'] == 'TaskCompleted'
      Task::CreateAuditLog.call(payload['data'])
    else
      # TODO: store invalid events in DB for later processing
    end
  end
end
