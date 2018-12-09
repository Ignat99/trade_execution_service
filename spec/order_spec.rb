require "rspec"
require "json"
require_relative "../app/order"

describe Order do

  before(:each) do
    @order = Order.new :side => "a", :size => 100, :currency => "USD", :counter_currency => 5, :date => "8/10/2018", :price => 200, :order_id => 150, :lp => "lpA"
  end

  it " is a make order transaction"  do
    @order.currency.should == "USD"
  end

  it " defind the amount in USD" do
    @order.amount == 100
  end

  it " is a make the payload hash" do
    @order.payload.should == {:order_type=>"market", :order_id=>150, :side=>"a", :order_qty=>100, :currency=>"USD", :value_date=>"8/10/2018", :price=>200}
  end

  it " is JSON dump" do
    @order.json_payload.should == '{"order_type":"market","order_id":150,"side":"a","order_qty":100,"currency":"USD","value_date":"8/10/2018","price":200}'
  end

  it " is a make the payload hash type A with Liquidity Provider A" do
    @order.payload_a.should == {:clOrdID=>150, :side=>"a", :orderQty=>100, :currency=>"USD", :futSettDate=>"8/10/2018", :price=>200}
  end

  it " is a make the payload hash type D with Liquidity Provider D" do
    @order.payload_b.should == {:clOrdID=>150, :side=>"a", :orderQty=>100, :currency=>"USD", :futSettDate=>"8/10/2018", :price=>200, :ordType=>"D"}
  end


#    order.execute_order(side, size, currency, counter_currency, date, price, order_id).should == true


end
