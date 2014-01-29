# encoding: UTF-8
module Pacman
  # Pink ghost strategy
  class PinkStrategy < RedStrategy
    def initialize()
      @scatter_target = Coordinate.new(3, 3)
      @timer = 0
      @state = SCATTER
      @target = nil
    end

    def chase_target(grid, player, ghosts)
      @target = player.grid_pos.neighbor(player.get_direction)
      @target = @target.neighbor(player.get_direction)
      @target = @target.neighbor(player.get_direction)
    end      
  end
end
