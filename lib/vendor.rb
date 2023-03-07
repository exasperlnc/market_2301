require_relative 'item'
class Vendor
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    if inventory.has_key?(item)
      return inventory[item]
    else
      return 0
    end
  end

  def stock(item, num)
    inventory[item] += num
  end

  def potential_revenue
    @inventory.map do |item, num|
      total = item.price.delete('$').to_f * num
    end.sum
  end

  def item_names
    all_names = []
    @inventory.each do |item, num|
      all_names << item.name if num > 0 
    end
    all_names
  end
end