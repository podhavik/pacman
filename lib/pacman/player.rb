# encoding: UTF-8
module Pacman
  # Player class
  class Player < GameObject
    attr_reader :score
    def initialize(window)
      # @image = Gosu::Image.new(window, "media/pacman.png", false)
      path = 'media/pacman_anim.png'
      path = ROOT_PATH + '/media/pacman_anim.png'
      @animation = Gosu::Image.load_tiles(window, path, 26, 26, false)
      @image = @animation[0]
      @counter = 0
      @animation_counter = 0
      path = ROOT_PATH + 'media/Beep.wav'
      @beep = Gosu::Sample.new(window, path)
      @x = @y = @vel_x = @vel_y = @angle = 0.0
      @speed = 1.37
      @score = 0
      @alive = true
    end

    def turn_left
      @angle = 180
      @vel_x = -@speed
      @vel_y = 0
    end

    def turn_right
      @angle = 0
      @vel_x = @speed
      @vel_y = 0
    end

    def turn_up
      @angle = 270
      @vel_x = 0
      @vel_y = -@speed
    end

    def turn_down
      @angle = 90
      @vel_x = 0
      @vel_y = @speed
    end

    def stop
      @vel_x = 0
      @vel_y = 0
    end

    def alive?
      @alive
    end

    def kill!
      @alive = false
    end

    def get_direction
      case @angle
      when 0
        dir = RIGHT
      when 180
        dir = LEFT
      when 270
        dir = UP
      else
        dir = DOWN
      end
      dir
    end

    def center_x
      if @x % BLOCK_SIZE != BLOCK_HSIZE
        if (BLOCK_HSIZE - (@x % BLOCK_SIZE)).abs < @vel_y.abs
          @x_mov = grid_x * BLOCK_SIZE + BLOCK_HSIZE
        else
          if @x % BLOCK_SIZE < BLOCK_HSIZE
            @x_mov = @x + @vel_y.abs
          else
            @x_mov = @x - @vel_y.abs
          end
        end
      end
    end

    def center_y
      if @y % BLOCK_SIZE != BLOCK_HSIZE
        # jesltize nejsem vycentrovany
        if (BLOCK_HSIZE - (@y % BLOCK_SIZE)).abs < @vel_x.abs
          # pokud je rychlost vetsi nez vzdalenost tka vycentruj
          @y_mov = grid_y * BLOCK_SIZE + BLOCK_HSIZE
        else
          # jinak o kousek poposun ke stredu horizontru
          if @y % BLOCK_SIZE < BLOCK_HSIZE
            @y_mov = @y + @vel_x.abs
          else
            @y_mov = @y - @vel_x.abs
          end
        end
      end
    end

    def move_on_x(new_grid_x, grid)
      # jestlitze mi v ceste stoji blok tak mi vycentruj a zastav
      if grid[new_grid_x][grid_y].class == Block
        @x_mov = grid_x * BLOCK_SIZE + BLOCK_HSIZE
        stop
      else
        center_y
      end
    end

    def move_on_y(new_grid_y, grid)
      if grid[grid_x][new_grid_y].class == Block
        @y_mov = grid_y * BLOCK_SIZE + BLOCK_HSIZE
        stop
      else
        center_x
      end
    end

    def update_pos
      @x_mov = @x + @vel_x
      @y_mov = @y + @vel_y
      @x_mov %= BLOCK_SIZE * GRIDX
      @y_mov %= BLOCK_SIZE * GRIDY
    end

    def move(grid, points)
      update_pos

      case get_direction
      when RIGHT
        if @x_mov % BLOCK_SIZE > BLOCK_HSIZE
          move_on_x((grid_x + 1) % GRIDX, grid)
        end
      when LEFT
        if @x_mov % BLOCK_SIZE < BLOCK_HSIZE
          move_on_x((grid_x - 1) % GRIDX, grid)
        end
      when UP
        if @y_mov % BLOCK_SIZE < BLOCK_HSIZE
          move_on_y((grid_y - 1) % GRIDY, grid)
        end
      when DOWN
        if @y_mov % BLOCK_SIZE > BLOCK_HSIZE
          move_on_y((grid_y + 1) % GRIDY, grid)
        end
      end

      update_state(grid, points)
    end

    def update_state(grid, points)
      oldx = grid_x
      oldy = grid_y

      warp(@x_mov, @y_mov)

      if (oldx != grid_x) || (oldy != grid_y)
        grid[oldx][oldy] = nil
        grid[grid_x][grid_y] = self
        collect_points(points)
      end
    end

    def moving?
      res = false
      res = true if @vel_x != 0 || @vel_y != 0
      res
    end

    def draw
      if moving? && alive?
        if @counter == 5
          @counter = 0
          @image = @animation[@animation_counter]
          @animation_counter += 1
          @animation_counter %= 4
        else
          @counter += 1
        end
      end
      @image.draw_rot(@x, @y, 1, @angle + 180) # draw_rot bere stred obrazku
    end

    def collect_points(points)
      points.reject! do |point|
        if point.grid_x == grid_x && point.grid_y == grid_y
          @score += 1
          @beep.play
          true
        else
          false
        end
      end
    end
  end
end
