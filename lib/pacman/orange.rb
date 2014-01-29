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
      @strategy = OrangeStrategy.new()
    end
  end
end
