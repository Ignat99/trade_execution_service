module HasProperties
  attr_accessor :props

  def has_properties *args
    @props = args
    instance_eval { attr_reader *args }
  end

  def self.included base
    base.extend self
  end

  def initialize(args)
    args.each {|k,v|
      instance_variable_set "@#{k}", v if self.class.props.member?(k)
    } if args.is_a? Hash
  end
end

# Or possible http://ruby-doc.org/core-2.5.3/Struct.html

class Order
  include HasProperties

  has_properties :side, :size, :currency, :counter_currency, :date, :price, :order_id, :lp
  attr_reader :amount

#{:side => "", :size => 0, :currency => "", :counter_currency => 0, \
#  :date => "", :price => 0, :order_id => 0, :lp => "" }

  def initialize args
    super
    @amount = amount_in_usd(size, currency)
  end

  def amount_in_usd(size, currency)
    # Calculate the dollar amount
    # it would return a Money object representing a USD amount
   return size
  end

  def payload
    { order_type: 'market', order_id: order_id, side: side, order_qty: size, currency: currency, value_date: date, price: price}
  end

  def json_payload
    JSON.dump(payload)
  end

  def payload_a
    {clOrdID: order_id, side: side, orderQty: size, currency: currency, futSettDate: date, price: price}
  end

  def payload_d
    payload_d = payload_a
    payload_d[:ordType] = 'D'
    return payload_d
  end
end
