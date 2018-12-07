class Order

  def initialize(size, currency)
    @amount = amount_in_usd(size, currency)
  end

  def amount_in_usd(size, currency)
    # Calculate the dollar amount
    # it would return a Money object representing a USD amount
  end
end
