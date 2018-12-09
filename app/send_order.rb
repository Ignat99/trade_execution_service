class SendOrder
  include HTTParty

  # this is a ruby constructor method
  # (executed when calling SendOrder.new)
  def initialize
    @connection = Redis.new(url: 'my_redis_host_url')
  end

  def send_post(post_url, body: json_payload)
    response = self.class.post('http://lp_c_host/trade', body: json_payload).response
    if response.code.to_i == 200
      handle_rest_trade_confirmation(response)
    else
      raise 'REST order execution failed.'
    end
  end

  def send_to_redis(queue, command, payload = nil)
    redis_msg = payload == nil ? command : "#{command}::#{JSON.dump(payload)}"
    @connection.rpush queue, redis_msg
  end
end