# encoding: UTF-8
module Pacman
  # Super class for game entities
  class GameObject
    attr_reader :x, :y
    def initialize
      @direction = UNDEF
      @x = 0
      @y = 0
    end

    def warp(x, y)
      @x, @y = x, y
    end

    def grid_pos
      Coordinate.new((@x / BLOCK_SIZE).floor, (@y / BLOCK_SIZE).floor)
    end

    def grid_x
      (@x / BLOCK_SIZE).floor
    end

    def grid_y
      (@y / BLOCK_SIZE).floor
    end
  end
end
