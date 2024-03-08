# frozen_string_literal: true

class CreatePolicyTask
  QUEUE_NAME = 'policy-api.create-policy'

  attr_reader :policy

  def initialize(args)
    @policy = args[:policy]
  end

  def self.publish!(args)
    new(args).publish
  end

  def publish
    connection = Bunny.new(hostname: 'rabbitmq')
    connection.start
    channel = connection.create_channel
    queue = channel.queue(QUEUE_NAME)

    channel.default_exchange.publish(policy, routing_key: queue.name)
    connection.close
  end
end
