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


end