class SendOrder

  def send_post(url, body: json_payload)
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