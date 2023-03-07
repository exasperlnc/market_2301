require 'market'
require 'rspec'

RSpec.describe Market do
  before(:each) do
    @market =  Market.new("South Pearl Street Farmers Market")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom") 
    @vendor3 = Vendor.new("Palisade Peach Shack") 
  end

  it 'exists' do
    expect(@market).to be_a(Market)
  end

  it 'has attributes' do
    expect(@market.name).to eq("South Pearl Street Farmers Market")
    expect(@market.vendors).to be_a(Array)
    expect(@market.date).to eq("07/03/2023")
  end

  it 'adds vendors and lists names' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7) 
    @vendor2.stock(@item4, 50) 
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors.count).to eq(3)
    expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]) #arr of names 
  end

  it 'returns vendors that sell' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7) 
    @vendor2.stock(@item4, 50) 
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
  end

  it 'sorts item list' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7) 
    @vendor2.stock(@item4, 50) 
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
  end

  it 'calucaltes total inventory' do
    @vendor1.stock(@item1, 35)
    @vendor2.stock(@item4, 50) 
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.total_inventory).to be_a(Hash)
    expect(@market.total_inventory).to eq({
      @item1 => {
        "vendors" => [@vendor1, @vendor3],
        "quantity" => 100
      },
      @item4 => {
        "vendors" => [@vendor2],
        "quantity" => 50
      }
      })
  end

  it 'checks for overstocked items' do
    @vendor1.stock(@item1, 35)
    @vendor2.stock(@item4, 70) 
    @vendor3.stock(@item1, 65)
    @vendor1.stock(@item2, 10)
    @vendor2.stock(@item2, 25)
    @vendor3.stock(@item3, 25)
    @vendor1.stock(@item3, 26)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.overstocked_items).to eq([@item1, @item3])
  end

  it 'sells item' do
    @vendor1.stock(@item1, 35)
    @vendor2.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    expect(@market.sell(@item1, 200)).to eq(false)
    expect(@market.overstocked_items).to eq([@item1])
    expect(@market.sell(@item1, 65)).to eq(true)
    expect(@vendor1.inventory[@item1]).to eq(0)
    expect(@vendor2.inventory[@item1]).to eq(35)
    expect(@market.overstocked_items).to eq([])
  end
end