class SendOrder
  include HTTParty

  # this is a ruby constructor method
  # (executed when calling SendOrder.new)
  def initialize
    @order = Order.new :side => "a", :size => 100, :currency => "USD", :counter_currency => 5, :date => "8/10/2018", :price => 200, :order_id => 150, :lp => "lpA"
    @connection = Redis.new(url: 'my_redis_host_url')
  end

  def send_post(url, body: @order.json_payload)
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