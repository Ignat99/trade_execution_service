require "rspec"
require_relative "../app/provider"

describe Provider do

  it "is a LIQUIDITY_PROVIDER_A"  do
    provider = Provider.new("lpA")
    provider.eql?("lpA").should == true
  end

end