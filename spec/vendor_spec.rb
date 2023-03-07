require './lib/vendor'
require 'rspec'

RSpec.describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item = Item.new({name: 'peach', price: "$0.50"})
  end
    it 'exists' do
      expect(@vendor).to be_a(Vendor)
    end

    it 'has attributes' do
      expect(@vendor.name).to eq("Rocky Mountain Fresh")
      expect(@vendor.inventory).to be_a(Hash)
    end

    it 'checks stock' do
      expect(@vendor.check_stock(@item)).to eq(0)
    end

    it 'adds stock' do
      @vendor.stock(@item, 10)
      expect(@vendor.check_stock(@item)).to eq(10)
      @vendor.stock(@item, 30)
      expect(@vendor.check_stock(@item)).to eq(40)
      expect(@vendor.inventory).to eq({@item => 40})
    end
  end