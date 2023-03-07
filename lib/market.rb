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

  def sorted_item_list
    @vendors.map do |vendor|
      vendor.item_names
    end.flatten.sort.uniq
  end

  def total_inventory
    total_inv = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, num|
        if total_inv[item]
          total_inv[item]["vendors"] << vendor
          total_inv[item]["quantity"] += num
        else
          new_hash = {}
          total_inv[item] = new_hash
          new_hash["vendors"] = []
          new_hash["quantity"] = 0
          new_hash["vendors"] << vendor
          new_hash["quantity"] += num
        end
      end
    end
    total_inv
  end

  def method_name
    
  end
end