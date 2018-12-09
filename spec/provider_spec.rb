require "rspec"
require_relative "../app/provider"

describe Provider do

  it "is a LIQUIDITY_PROVIDER_A"  do
    provider = Provider.new("lpA")
    provider.eql?("lpA").should == true
  end

  before(:each) do
    @order = Order.new :side => "a", :size => 1000, :currency => "USD", :counter_currency => 5, :date => "8/10/2018", :price => 200, :order_id => 150
    @provider = Provider.from_amount(@order.amount)
  end


  it " selected from amount" do
    @provider.eql?("lpA").should == true
  end

  it " defined by order " do
    @order.lp = @provider
    @order.class.props[7].eql?("lp")
  end

  it " dfedined command " do
    @provider.command.eql?('fix:trades:lp_a:NewOrderSingle')
  end

  it " show the constant name " do
    Provider::LIQUIDITY_PROVIDER_B.eql?("lpB")
  end
end
