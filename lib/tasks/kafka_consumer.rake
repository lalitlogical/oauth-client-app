namespace :kafka do
  desc "Start Kafka Consumer"
  task consume: :environment do
    KafkaConsumer.new.consume
  end
end
