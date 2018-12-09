require "rspec"
require_relative "../app/provider"

describe Provider do

  it "is a LIQUIDITY_PROVIDER_A"  do
    provider = Provider.new("lpA")
    provider.eql?("lpA").should == true
  end

  it " selected from amount" do
    order = Order.new :side => "a", :size => 100, :currency => "USD", :counter_currency => 5, :date => "8/10/2018", :price => 200, :order_id => 150
    provider = Provider.from_amount(order.amount)
    provider.eql?("lpA").should == true
  end


end