# encoding: UTF-8
module Pacman
  # Cyan ghost strategy
  class CyanStrategy < RedStrategy
    def initialize()
      @scatter_target = Coordinate.new(GRIDX - 3, GRIDY - 3)
      @timer = 0
      @state = SCATTER
      @target = nil
    end

    def get_red(ghosts)
      for i in 0..ghosts.length
        if ghosts[i].class == Red
          res = ghosts[i]
          break
        end
      end
      res
    end

    def chase_target(grid, player, ghosts)
      red = get_red(ghosts).grid_pos
      @target = player.grid_pos.neighbor(player.get_direction)
      @target = @target.neighbor(player.get_direction)
      offset_x = @target.x - red.x
      offset_y = @target.y - red.y
      @target = Coordinate.new(@target.x + offset_x, @target.y + offset_y)
    end
  end
end
