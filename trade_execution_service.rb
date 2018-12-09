require "httparty"
require_relative "./app/order"
require_relative "./app/send_order"
require_relative "./app/provider"

class TradeExecutionService < SendOrder

#  LOG_FILE  = 'path_to_log_file/errors.log'
  LOG_FILE  = './errors.log'
  POST_URL  = 'http://lp_c_host/trade'
  REDIS_URL = 'my_redis_host_url'

  def initialize
    super(REDIS_URL)
  end

  def execute_order(order)
    if order.lp == Provider::LIQUIDITY_PROVIDER_C
      send_by_post(POST_URL, order.json_payload)
    elsif
      check_fix_service_status(lp)
      if order.lp == Provider::LIQUIDITY_PROVIDER_A
        send_to_redis_a(order.lp.command, order.payload_a)
      else
# order.lp == Provider::LIQUIDITY_PROVIDER_B
        send_to_redis_b(order.lp.command, order.payload_b)
      end
      response = wait_for_fix_response(order.order_id, order.lp)
      handle_fix_trade_confirmation(response)
    end
  rescue
    failed_of_market_trade(LOG_FILE,order.order_id)
  end

  def failed_of_market_trade(log_file,order_id)
    File.open(log_file, 'a') do |f|
      f.puts "Execution of #{order_id} failed."
    end
  end

  def handle_rest_trade_confirmation(rest_trade_confirmation)
    # trade confirmation will be persisted in db
  end

  def handle_fix_trade_confirmation(fix_trade_confirmation)
    # trade confirmation will be persisted in db
  end

  def wait_for_fix_response(order_id, lp)
    # blocking read waiting for a redis key where trade confirmation is stored
  end
end

order = Order.new :side => "a", :size => 100, :currency => "USD", :counter_currency => 5, :date => "8/10/2018", :price => 200, :order_id => 150
order.lp = Provider.from_amount(order.amount)
tes = TradeExecutionService.new
puts tes.execute_order(order)
