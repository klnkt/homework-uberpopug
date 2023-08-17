module Events
  class ProduceEvent
    def initialize(topic:, payload:)
      @payload = payload
      @topic = topic
    end

    def call
      Karafka.Karafka.producer.produce_sync(
        topic:,
        payload:
      )
    end
  end
end
