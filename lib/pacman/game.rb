# encoding: UTF-8
# define usual constants
module Pacman
  LEFT = 0
  UP = 1
  RIGHT = 2
  DOWN = 3
  UNDEF = 5

  GRIDX = 28
  GRIDY = 36

  BLOCK_SIZE = 16
  BLOCK_HSIZE = 8
  # Represent game model
  class Game
    attr_accessor :player, :points, :score, :grid, :ghosts, :win, :lose

    def axis_val(x)
      BLOCK_SIZE * x + BLOCK_HSIZE
    end

    def load_map(window, map)
      map.each_with_index do
        |row, y| row.each_with_index do
          |col, x|
          case col
          when 's'
            @grid[x][y] = @player
            @player.warp(axis_val(x), axis_val(y))
          when 'x'
            @grid[x][y] = Block.new(window)
            @grid[x][y].warp(axis_val(x), axis_val(y))
          when 'p'
            point = Point.new(window)
            @grid[x][y] = point
            @grid[x][y].warp(axis_val(x), axis_val(y))
            @points.push(point)
          when 'r'
            ghost = Red.new(window)
            ghosts.push(ghost)
            @grid[x][y] = ghost
            @grid[x][y].warp(axis_val(x), axis_val(y))
          when 'i'
            ghost = Pink.new(window)
            ghosts.push(ghost)
            @grid[x][y] = ghost
            @grid[x][y].warp(axis_val(x), axis_val(y))
          when 'a'
            ghost = Orange.new(window)
            ghosts.push(ghost)
            @grid[x][y] = ghost
            @grid[x][y].warp(axis_val(x), axis_val(y))
          when 'c'
            ghost = Cyan.new(window)
            ghosts.push(ghost)
            @grid[x][y] = ghost
            @grid[x][y].warp(axis_val(x), axis_val(y))
          end
        end
      end
    end

    def initialize(window, opts)
      path = opts[:file]
      if path == nil
        path = ROOT_PATH + '/levels/lvl.txt'
      else
        path = ROOT_PATH + '/levels/' + path
      end      
      map = File.foreach(path).map { |line| line.split(' ') }
      @player = Player.new(window)
      @player.warp(320, 240)
      @points = []
      @ghosts = []
      @score = 0
      @win = false
      @lose = false
      @grid = Array.new(GRIDX) { Array.new(GRIDY) }
      load_map(window, map)
    end

    def pressed_left
      if @grid[(@player.grid_x - 1) % GRIDX][@player.grid_y].class != Block
        @player.turn_left
      end
    end

    def pressed_right
      if @grid[(@player.grid_x + 1) % GRIDX][@player.grid_y].class != Block
        @player.turn_right
      end
    end

    def pressed_up
      if @grid[@player.grid_x][(@player.grid_y - 1) % GRIDY].class != Block
        @player.turn_up
      end
    end

    def pressed_down
      if @grid[@player.grid_x][(@player.grid_y + 1) % GRIDY].class != Block
        @player.turn_down
      end
    end

    def update
      @player.move(@grid, @points)
      @ghosts.each { |ghost| ghost.move(@grid, @player, @ghosts) }

      @win = true if @points.length == 0
      @lose = true if @player.alive? == false
    end
  end
end
