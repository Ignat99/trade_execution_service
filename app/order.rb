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


#{:side => "", :size => 0, :currency => "", :counter_currency => 0, \
#  :date => "", :price => 0, :order_id => 0, :lp => "" }

  def initialize args
    super
    @amount = amount_in_usd(size, currency)
  end


  def amount_in_usd(size, currency)
    # Calculate the dollar amount
    # it would return a Money object representing a USD amount
  end
end
