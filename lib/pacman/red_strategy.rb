# encoding: UTF-8
module Pacman
  # Red ghost strategy
  class RedStrategy
    SCATTER = 1
    CHASE = 2
    AFRAID = 3
    DEAD = 4
    attr_reader :target, :state
    def initialize()
      @scatter_target = Coordinate.new(GRIDX - 3, 3)
      @timer = 0
      @state = SCATTER
      @target = nil
    end
    
    def chase_target(grid, player, ghosts)
      player.grid_pos 
    end

    def tick(grid, player, ghosts)
      @timer += 1
      if @timer <= 1650 && @state == CHASE
        @target = chase_target(grid, player, ghosts)
        if @timer == 1650
          @timer = 0
          @state = SCATTER
        end
      end

      if @timer <= 330 && @state == SCATTER
        @target = @scatter_target
        if @timer == 330
          @timer = 0
          @state = CHASE
        end
      end
    end
  end
end
