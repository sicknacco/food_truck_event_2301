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

  # def overstocked_items
  #   overstock = []

  # end
end
