# encoding: UTF-8
module Pacman
  # Pink ghost
  class Pink < Red
    def initialize(window)
      path = ROOT_PATH + '/media/pink.png'
      @image = Gosu::Image.new(window, path, false)
      @x = @y = @vel_x = @vel_y = @angle = 0.0
      @speed = 1.35
      @direction = LEFT
      @enter_field = true
      @pass_center = false
      @vel_x = -@speed
      @scatter_target = Coordinate.new(3, 3)
      @timer = 0
      @state = SCATTER
    end

    def set_target(grid, player, ghosts)
      @target = player.grid_pos.neighbor(player.get_direction)
      @target = @target.neighbor(player.get_direction)
      @target = @target.neighbor(player.get_direction)
    end
  end
end
