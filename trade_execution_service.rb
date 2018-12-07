class TradeExecutionService
  include HTTParty

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