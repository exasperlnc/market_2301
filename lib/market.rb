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

  def overstocked_items
    overstocker = []
    total_inventory.each do |item, item_hash|
      if item_hash["vendors"].count > 1 && item_hash["quantity"] > 50
        overstocker << item
      end
    end
  overstocker
  end

  def sell(item, quantity)
    if total_inventory[item]["quantity"] < quantity
      return false
    else
      counter = quantity
      @vendors.each do |vendor|
        until vendor.inventory[item] == 0 || counter == 0
          counter -= 1
          vendor.inventory[item] -= 1
        end
      end
      return true
    end
  end
end