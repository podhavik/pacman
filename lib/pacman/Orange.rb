# encoding: UTF-8
module Pacman
  # Orange ghost
  class Orange < Red
    def initialize(window)
      path = ROOT_PATH + '/media/orange.png'
      @image = Gosu::Image.new(window, path, false)
      @x = @y = @vel_x = @vel_y = @angle = 0.0
      @speed = 1.35
      @direction = LEFT
      @enter_field = true
      @pass_center = false
      @vel_x = -@speed
      @scatter_target = Coordinate.new(3, GRIDY - 3)
      @timer = 0
      @state = SCATTER
    end

    def set_target(grid, player, ghosts)
      if player.grid_pos.distance(grid_pos) > 7
        @target = player.grid_pos
      else
        @target = @scatter_target
      end
    end
  end
end
