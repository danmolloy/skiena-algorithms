# There are 25 horses. At most, 5 horses can race together at a time. You must
# determine the fastest, second fastest, and third fastest horses. Find the minimum
# number of races in which this can be done.

#race 5 horses. delete bottom 2. repeat. return when 3 remain. 11 races
MAX_HORSES = 5
class Horse
  attr_accessor :speed
  def initialize (speed)
    @speed = speed
  end
end

class Race
  def self.race(horses)
    return nil if horses.count > MAX_HORSES
    horses.sort_by {|horse| horse.speed}
  end
end

def generate_horses
  horses = []
  25.times {horses << Horse.new(Random.new.rand(100))}
  puts sort_horses_by_speed(horses)
  horses
end

def sort_horses_by_speed(horses)
  horses.sort_by {|h| h.speed}.map{|h| h.speed}.reverse
end

def main
  horses = generate_horses
  while horses.length > 3
    results = Race.race(horses.first(5))
    puts "race results:"
    puts results.map{|h| h.speed}
    horses.delete(results[0])
    horses.delete(results[1])
  end

  puts "fastest horses: "
  puts sort_horses_by_speed(horses)
end

main
