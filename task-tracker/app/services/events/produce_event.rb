module Events
  class ProduceEvent
    def initialize(topic:, payload:)
      @payload = payload
      @topic = topic
    end

    def call
      Karafka.producer.produce_sync(
        topic:,
        payload:
      )
    end
  end
end
