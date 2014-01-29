# encoding: UTF-8
module Pacman
  # Orange ghost strategy
  class OrangeStrategy < RedStrategy
    def initialize()
      @scatter_target = Coordinate.new(3, GRIDY - 3)
      @timer = 0
      @state = SCATTER
      @target = nil
    end

    def get_orange(ghosts)
      for i in 0..ghosts.length
        if ghosts[i].class == Orange
          res = ghosts[i]
          break
        end
      end
      res
    end

    def chase_target(grid, player, ghosts)
      if player.grid_pos.distance(get_orange(ghosts).grid_pos) > 7
        @target = player.grid_pos
      else
        @target = @scatter_target
      end
    end
  end
end
