require_relative 'vendor'
class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    vendors_with_item = []
    vendors.each {|vendor| vendors_with_item << vendor if vendor.check_stock(item)}
    vendors_with_item
  end
end