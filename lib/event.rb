class Event
  attr_reader :name,
              :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_truck(truck)
    @food_trucks << truck
  end
end
