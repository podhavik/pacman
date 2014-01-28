# encoding: UTF-8
module Pacman
  # Wall in maze
  class Block < GameObject
    def initialize(window)
      path = ROOT_PATH + '/media/block.png'
      @image = Gosu::Image.new(window, path, false)
      @x = @y = 0.0
    end

    def draw
      @image.draw_rot(@x, @y, 1, 0) # draw_rot bere stred obrazku
    end
  end
end
