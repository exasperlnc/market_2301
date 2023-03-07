require './lib/item'
require 'rspec'

RSpec.describe Item do
  before(:each) do
    @item = Item.new({name: 'peach', price: "$0.50"})
  end

  it 'exists' do
    expect(@item).to be_a (Item)
  end

  it 'has attributes' do
    expect(@item.name).to eq('peach')
    expect(@item.price).to eq('$0.50')
  end
end