require "kafka"

class KafkaConsumer
  def initialize(topic = "doorkeeper-events", group_id = "client_app")
    brokers = ENV.fetch("KAFKA_BROKERS", "localhost:9092")
    @kafka = Kafka.new(brokers.split(","))
    @topic = topic
    @group_id = group_id
  end

  def consume
    consumer = @kafka.consumer(group_id: @group_id)
    consumer.subscribe(@topic)

    consumer.each_message do |message|
      data = JSON.parse(message.value)
      Rails.logger.info("Received event: #{data["event"]}")
      handle_event(data)
    end
  end

  private

  def handle_event(data)
    case data["event"]
    when "user_logged_in"
      puts "User logged in from IDP: #{data["payload"]["email"]}"
    when "user_active_state"
      puts "User active state from IDP: #{data["payload"]["email"]} is active #{data["payload"]["active"]}"
      user = User.find_by(email: data["payload"]["email"])
      user.update(active: data["payload"]["active"]) if user
    end
  end
end
