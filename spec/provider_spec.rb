require "rspec"
require_relative "../app/provider"

describe Provider do

  it "is a LIQUIDITY_PROVIDER_A"  do
    provider = Provider.new("lpA")
    expect(provider).to eq("lpA")
  end

  before(:each) do
    @order = Order.new :side => "a", :size => 1000, :currency => "USD", :counter_currency => 5, :date => "8/10/2018", :price => 200, :order_id => 150
    @provider = Provider.from_amount(@order.amount)
  end


  it "selected from amount" do
    expect(@provider).to eq("lpA")
  end

  it "defined by order" do
    @order.lp = @provider
    expect(@order.class.props[7]).to eq(:lp)
  end

  it "defined command" do
    expect(@provider.command).to eq("fix:trades:lp_a:NewOrderSingle")
  end

  it "show the constant name" do
    expect(Provider::LIQUIDITY_PROVIDER_B).to eq("lpB")
  end
end
