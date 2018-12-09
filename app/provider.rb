class Fixnum

  def to_money(currency)
      self
  end
end

class Provider
  include Comparable

  LIQUIDITY_PROVIDER_A = "lpA"
  LIQUIDITY_PROVIDER_B = "lpB"
  LIQUIDITY_PROVIDER_C = "lpC"
  USD = "USD"

  def self.from_amount(amount)
    if amount < 10_000.to_money(USD)
      new(LIQUIDITY_PROVIDER_A)
    elsif amount < 100_000.to_money(USD)
      new(LIQUIDITY_PROVIDER_B)
    else
      new(LIQUIDITY_PROVIDER_C)
    end
  end

  def initialize(lp)
    @lp = lp
  end

  def command
    if @lp.eql?(LIQUIDITY_PROVIDER_A)
      return 'fix:trades:lp_a:NewOrderSingle'
    elsif @lp.eql?(LIQUIDITY_PROVIDER_B)
      return 'fix:trades:lp_b:NewOrderSingle'
    else
      return nil
    end
  end


  def check_fix_service_status(lp)
    # it will throw an Exception if there is no connectivity with
    # this LP fix service  
  end

  def bigger_than?(other)
    self > other
  end

  def <=>(other)
    other.to_s <=> to_s
  end

  def hash
    @lp.hash
  end

  def eql?(other)
    to_s == other.to_s
  end

  def to_s
    @lp.to_s
  end
end