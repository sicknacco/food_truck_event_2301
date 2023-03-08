require 'rspec'
require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do
  before(:each) do
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  it 'exists and has attributes' do
    expect(@event).to be_a(Event)
    expect(@event.name).to eq("South Pearl Street Farmers Market")
    expect(@event.food_trucks).to eq([])
  end

  it 'can add trucks to the event' do
    @event.add_food_truck(@food_truck1)
    expect(@event.food_trucks).to eq([@food_truck1])
  end
  
  it 'trucks can stock items' do
    @event.add_food_truck(@food_truck1)
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    expect(@food_truck1.inventory).to eq({@item1 => 35, @item2 => 7})
    
    @event.add_food_truck(@food_truck2)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    expect(@food_truck2.inventory).to eq({@item4 => 50, @item3 => 25})
    
    @event.add_food_truck(@food_truck3)
    @food_truck3.stock(@item1, 65)
    expect(@food_truck3.inventory).to eq({@item1 => 65})
  end

  it 'can list all truck names in array of strings' do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
    expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it 'can determine what trucks sell a specific item' do
    @event.add_food_truck(@food_truck1)
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    
    @event.add_food_truck(@food_truck2)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    
    @event.add_food_truck(@food_truck3)
    @food_truck3.stock(@item1, 65)

    expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
    expect(@event.food_trucks_that_sell(@item2)).to eq([@food_truck1])
    expect(@event.food_trucks_that_sell(@item3)).to eq([@food_truck2])
    expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
  end

  it 'can determine a trucks potential revenue' do
    @event.add_food_truck(@food_truck1)
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    
    @event.add_food_truck(@food_truck2)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    
    @event.add_food_truck(@food_truck3)
    @food_truck3.stock(@item1, 65)

    expect(@food_truck1.potential_revenue).to eq(148.75)
    expect(@food_truck2.potential_revenue).to eq(345)
    expect(@food_truck3.potential_revenue).to eq(243.75)
  end

  it 'can determine if an item is overstocked' do
    @event.add_food_truck(@food_truck1)
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    
    @event.add_food_truck(@food_truck2)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    
    @event.add_food_truck(@food_truck3)
    @food_truck3.stock(@item1, 65)
    @food_truck3.stock(@item4, 10)
    
    expect(@event.overstocked_items).to eq([@item1, @item4])
  end
end