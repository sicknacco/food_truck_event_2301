class Event
  attr_reader :name,
              :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    trucks = []
    @food_trucks.select do |food_truck|
      if food_truck.inventory.keys.include?(item)
        trucks << item
      end
    end
  end

  def sorted_item_list
    items = []
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, value|
        if value >0
          items << item.name
        end
      end
    end
    items.sort.uniq
  end

  def total_inventory
    trucks_stock = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, quantity|
        if trucks_stock[item]
          trucks_stock[item][:quantity] += quantity
        else
          trucks_stock[item] = {quantity: food_truck.inventory[item],
            food_trucks: food_trucks_that_sell(item)}
        end
      end
    end
    trucks_stock
  end

  def overstocked_items
    overstock = []
    total_inventory.each do |item, product_hash|
      if product_hash[:quantity] > 50 && product_hash[:food_trucks].length > 1
        overstock << item
      end
    end
    overstock
  end
end
