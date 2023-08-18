module Events
  class ProduceEvent
    class << self
      def call(topics:, payload:)
        puts payload
        topics.each do |topic|
          Karafka.producer.produce_sync(
            topic: topic,
            payload: payload.to_json
          )
        end
      end
    end
  end
end
