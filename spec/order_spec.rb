require "rspec"
require "json"
require_relative "../app/order"

describe Order do

  before(:each) do
    @order = Order.new :side => "a", :size => 100, :currency => "USD", :counter_currency => 5, :date => "8/10/2018", :price => 200, :order_id => 150, :lp => "lpA"
  end

  it "is a make order transaction"  do
    expect(@order.currency).to eq("USD")
  end

  it "defind the amount in USD" do
    expect(@order.amount).to eq(100)
  end

  it "is a make the payload hash" do
    expect(@order.payload).to eq({:order_type=>"market", :order_id=>150, :side=>"a", :order_qty=>100, :currency=>"USD", :value_date=>"8/10/2018", :price=>200})
  end

  it "is JSON dump" do
    expect(@order.json_payload).to eq( '{"order_type":"market","order_id":150,"side":"a","order_qty":100,"currency":"USD","value_date":"8/10/2018","price":200}')
  end

  it "is a make the payload hash type A with Liquidity Provider A" do
    expect(@order.payload_a).to eq({:clOrdID=>150, :side=>"a", :orderQty=>100, :currency=>"USD", :futSettDate=>"8/10/2018", :price=>200})
  end

  it "is a make the payload hash type D with Liquidity Provider D" do
    expect(@order.payload_b).to eq({:clOrdID=>150, :side=>"a", :orderQty=>100, :currency=>"USD", :futSettDate=>"8/10/2018", :price=>200, :ordType=>"D"})
  end
end
