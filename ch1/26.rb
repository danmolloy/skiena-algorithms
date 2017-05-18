# Implement the two TSP heuristics of Section 1.1 (page 5). Which of them gives
# better-quality solutions in practice? Can you devise a heuristic that works better
# than both of them?

# NearestNeighbor(P)
# Pick and visit an initial point p0 from P
# p = p0
# i = 0
# While there are still unvisited points
# i = i + 1
# Select pi to be the closest unvisited point to pi−1
# Visit pi
# Return to p0 from pn−1

# ClosestPair(P)
# Let n be the number of points in set P.
# For i = 1 to n − 1 do
# d = ∞
# For each pair of endpoints (s,t) from distinct vertex chains
# if dist(s,t) ≤ d then sm = s, tm = t, and d = dist(s,t)
# Connect (sm,tm) by an edge
# Connect the two endpoints by an edge

class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def xy
    "#{x}, #{y}"
  end

  def ==(point)
    if @x == point.x && @y == point.y
      return true
    else
      return false
    end
  end
end

class PointCollection
  attr_reader :points
  def initialize
    @points = []
  end

  def add(x, y)
    point = Point.new(x, y)
    if @points.include? point
      return false
    else
      @points << point
      return true
    end
  end

  def remove(x, y)
    @points.delete(Point.new(x, y))
  end
end

def distance(a, b)
  Math.sqrt((a.x - b.x)**2 + (a.y - b.y)**2)
end

def find_nearest_neighbour(point, points)
  nearest_point = points[0]
  nearest_distance = distance(point, points[0])
  points[1..-1].each do |neighbour|
    distance = distance(point, neighbour)
    if distance < nearest_distance
      nearest_distance = distance
      nearest_point = neighbour
    end
  end
  return nearest_point, nearest_distance
end

def nearest_neighbour(points)
  distance_travelled = 0
  initial_point = points[0]
  current_point = initial_point
  points.delete(current_point)
  while points.length > 0
    puts points.map{|point| point.xy}
    puts "points length: #{points.length}"
    puts "current point: #{current_point.xy}"
    nearest_point, nearest_distance = find_nearest_neighbour(current_point, points)
    distance_travelled += nearest_distance
    puts "nearest neighbour: #{nearest_point.xy}"
    puts "distance increment: #{nearest_distance}"
    puts "total distance: #{distance_travelled}"
    current_point = nearest_point
    points.delete(current_point)
  end
  puts "total distance before closing loop: #{distance_travelled}"
  distance_travelled += distance(current_point, initial_point)
  puts "total distance after closing loop: #{distance_travelled}"
  return distance_travelled
end

collection = PointCollection.new

while collection.points.length < 10 do
  collection.add(Random.new.rand(10), Random.new.rand(10))
end

nearest_neighbour(collection.points)
