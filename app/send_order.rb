class SendOrder
  include HTTParty

  # this is a ruby constructor method
  # (executed when calling SendOrder.new)
  def initialize(redis_url)
    @connection = Redis.new(url: redis_url)
  end

  def send_by_post(post_url, json_payload)
    response = self.class.post(post_url, body: json_payload).response
    if response.code.to_i == 200
      handle_rest_trade_confirmation(response)
    else
      puts 'Error'
      raise 'REST order execution failed.'
    end
  end

  def send_to_redis(queue, command, payload = nil)
    redis_msg = payload == nil ? command : "#{command}::#{JSON.dump(payload)}"
    @connection.rpush queue, redis_msg
  end

  def send_to_redis_a(command, payload)
    send_to_redis(:lp_a_queue, command, payload = nil)
  end

  def send_to_redis_b(command, payload)
    send_to_redis(:lp_b_queue, command, payload = nil)
  end

end
