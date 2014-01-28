# encoding: UTF-8
module Pacman
  # Represent position in grid
  class Coordinate
    attr_accessor :x, :y
    def initialize(x, y)
      @x = x
      @y = y
    end

    def neighbor(direction)
      x = @x
      y = @y
      x -= 1 if direction == LEFT
      x += 1 if direction == RIGHT
      y -= 1 if direction == UP
      y += 1 if direction == DOWN

      Coordinate.new(x, y)
    end

    def get_direction(coord)
      res = UNDEF

      res = LEFT if @x > coord.x
      res = RIGHT if @x < coord.x
      res = UP if @y > coord.y
      res = DOWN if @y < coord.y
      res
    end

    # manhatan
    def distance(coord)
      x = @x - coord.x
      y = @y - coord.y
      x.abs + y.abs
    end
  end
end
