# encoding: UTF-8
module Pacman
  # Red ghost
  class Red < GameObject
    attr_reader :speed, :state
    def initialize(window)
      path = ROOT_PATH + '/media/red.png'
      @image = Gosu::Image.new(window, path, false)
      @x = @y = @vel_x = @vel_y = @angle = 0.0
      @speed = 1.36
      @direction = LEFT
      @enter_field = true
      @pass_center = false
      @vel_x = -@speed
      @strategy = RedStrategy.new()
    end

    def draw
      # draw_rot bere stred obrazku
      @image.draw_rot(@x, @y, 1, @angle)
      # @image.draw(@x, @y, 1, -1, 1)
    end

    def posible_fields(next_field, grid)
      # najdi pristi volne
      free_g = []
      # je volno ve smeru kudy jdu?
      mem = next_field.neighbor(@direction)
      free_g.push(mem) if grid[mem.x][mem.y].class != Block
      # je volno "vlevo"
      mem = next_field.neighbor((@direction - 1) % 4)
      free_g.push(mem) if grid[mem.x][mem.y].class != Block
      # je volno "vpravo"
      mem = next_field.neighbor((@direction + 1) % 4)
      free_g.push(mem) if grid[mem.x][mem.y].class != Block
      free_g
    end

    def change_dir(grid)
      next_field = grid_pos

      free_g = posible_fields(next_field, grid)
      # urci nejblizsi smer k target pokud mam vic moznosti
      if free_g.length == 0
        # obraceni v jednosmerce
        best = grid_pos.neighbor((@direction + 2) % 4)
      else
        best = free_g[0]
        free_g.each do
          |i| best = i if i.distance(@target) < best.distance(@target)
        end
      end

      # nastavi se direction
      @direction = next_field.get_direction(best)
      # nastavime field=false protoze vnem jiz sme
      @enter_field = false
    end

    def set_speed
      @vel_x = 0
      @vel_y = 0
      @vel_x = -@speed if @direction == LEFT
      @vel_x = @speed if @direction == RIGHT
      @vel_y = -@speed if @direction == UP
      @vel_y = @speed if @direction == DOWN
    end

    def get_direction
      case @vel_x
      when -@speed
        dir = LEFT
      when @speed
        dir = RIGHT
      end
      case @vel_y
      when -@speed
        dir = UP
      when @speed
        dir = DOWN
      end
      dir
    end

    def update_grid(x_mov, y_mov, grid)
      las_grid_x = grid_x
      las_grid_y = grid_y
      warp(x_mov, y_mov)
      if las_grid_x != grid_x || las_grid_y != grid_y
        grid[las_grid_x][las_grid_y] = nil
        grid[grid_x][grid_y] = self
        @enter_field = true
        @pass_center = false
      end
    end

    def kill_pacman(player)
      player.kill! if grid_x == player.grid_x && grid_y == player.grid_y
    end

    def move(grid, player, ghosts)
      @strategy.tick(grid, player, ghosts)
      @target = @strategy.target

      # pokud jsme vstoupili na nove policko
      change_dir(grid) if @enter_field == true

      # posun
      x_mov = @x + @vel_x
      y_mov = @y + @vel_y
      # % zajisti vyjeti mimo obrazovku
      x_mov %= BLOCK_SIZE * GRIDX
      y_mov %= BLOCK_SIZE * GRIDY

      # projedu za pulku soucasneho fieldu?
      # pokud ano musim se spravne posunout a zmenit smer
      if @pass_center == false
        case get_direction
        when LEFT
          if x_mov < grid_x * BLOCK_SIZE + BLOCK_HSIZE
            x_mov = grid_x * BLOCK_SIZE + BLOCK_HSIZE
            set_speed
            @pass_center = true
          end
        when RIGHT
          if x_mov > grid_x * BLOCK_SIZE + BLOCK_HSIZE
            x_mov = grid_x * BLOCK_SIZE + BLOCK_HSIZE
            set_speed
            @pass_center = true
          end
        when UP
          if y_mov < grid_y * BLOCK_SIZE + BLOCK_HSIZE
            y_mov = grid_y * BLOCK_SIZE + BLOCK_HSIZE
            set_speed
            @pass_center = true
          end
        when DOWN
          if y_mov > grid_y * BLOCK_SIZE + BLOCK_HSIZE
            y_mov = grid_y * BLOCK_SIZE + BLOCK_HSIZE
            set_speed
            @pass_center = true
          end
        else
          p 'unknown direction of red'
        end
      end

      # posuny v mrizce
      update_grid(x_mov, y_mov, grid)
      kill_pacman(player)
    end
  end
end
