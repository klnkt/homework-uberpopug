module Events
  class ProduceEvent
    class << self
      def call(topics:, event_data:)
        puts payload
        topics.each do |topic|
          emit_event(topic, event_data)
        end
      end

      private

      def emit_event(topic, event_data)
        event_type = event_data[:event_type]
        payload = event_data[:payload]
        event_version = event_data[:version]

        result = SchemaRegistry.validate_event(payload, event_type, version: event_version)

        if result.success?
          Karafka.producer.produce_sync(
            topic: topic,
            payload: payload.to_json
          )
        else
          # TODO: save in the DB for later processing
          puts "Event #{event_type} is invalid: #{result.errors}"
        end
      end
    end
  end
end
