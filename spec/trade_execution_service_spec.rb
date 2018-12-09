require "rspec"
require "httparty"
require "json"
require_relative "../app/order"
require_relative "../trade_execution_service"

describe TradeExecutionService do

  before(:each) do
    @order = Order.new :side => "a", :size => 100, :currency => "USD", :counter_currency => 5, :date => "8/10/2018", :price => 200, :order_id => 150
    @tes = TradeExecutionService.new
  end

  it " open log file " do
    LOG_FILE = "./errors.log"
    @tes.failed_of_market_trade(LOG_FILE, @order.order_id)
    File.open(LOG_FILE, 'r') do |f|
      f.each_line do |line|
        if line == "Execution of 150 failed.\n"
          true
        else
          false
        end
      end
    end
    File.delete(LOG_FILE) if File.exists? LOG_FILE
  end

  it " for execute order " do
    provider = Provider.from_amount(@order.amount)
    @order.lp = provider
#    @tes.execute_order(provider, @order)
    puts @order.lp.command
  end

end