require "kafka"

class KafkaConsumer
  def initialize(topics:, group_id:)
    @brokers = ENV.fetch("KAFKA_BROKERS", "localhost:9092").split(",")
    @topics = Array(topics)
    @group_id = group_id
  end

  def consume
    kafka = Kafka.new(@brokers)
    consumer = kafka.consumer(group_id: @group_id)

    @topics.each { |topic| consumer.subscribe(topic) }

    Rails.logger.info "✅ KafkaConsumer started for group=#{@group_id}, topics=#{@topics.join(', ')}"

    consumer.each_message do |message|
      data = JSON.parse(message.value)
      Rails.logger.info("Received event: #{data["event"]}")
      handle_event(data)
    rescue => e
      Rails.logger.error "❌ Failed to process message: #{e.message}"
    end
  end

  private

  def handle_event(data)
    case data["event"]
    when "user.logged_in"
      Rails.logger.info "User logged in from IDP: #{data["payload"]["email"]}"
    when "user.activated", "user.deactivated"
      Rails.logger.info "User active state from IDP: #{data["payload"]["email"]} is active #{data["payload"]["active"]}"

      user = User.find_by(openid: data["payload"]["user_id"])
      user.update(active: data["payload"]["active"]) if user
    end
  end
end
