namespace :kafka do
  desc "Start Kafka Consumer"
  task consume: :environment do
    consumer = KafkaConsumer.new(
      topics: [ "user_events" ],
      group_id: "client_app",
    )

    consumer.consume
  end
end
