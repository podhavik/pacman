# encoding: UTF-8
module Pacman
  # Rendering of game
  class Screen
    def initialize(window, game)
      @game = game
      @window = window
      @font = Gosu::Font.new(window, Gosu.default_font_name, 20)
    end

    def draw_info
      s = "Score: #{@game.player.score}"
      @font.draw(s, 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
      s =  "FPS: #{@window.fps}"
      @font.draw(s, 120, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    end

    def draw_end
      if @game.win == true
        s = 'WIN'
        @font.draw(s, 170, 250, ZOrder::UI, 3.0, 3.0, 0xffffff00)
      end
      if @game.lose == true
        s = 'LOSE'
        @font.draw(s, 170, 250, ZOrder::UI, 3.0, 3.0, 0xffffff00)
      end
      if @game.lose == true || @game.win == true
        s = 'Press [Enter] for new game'
        @font.draw(s, 130, 350, ZOrder::UI, 1.0, 1.0, 0xffffff00)
      end
    end

    def draw
      @game.points.each { |point| point.draw }
      @game.grid.each do
        |row| row.each do
          |cel| cel.draw if cel.class == Block || cel.class == Point
        end
      end
      @game.ghosts.each { |ghost| ghost.draw }
      @game.player.draw
      draw_info
      draw_end
    end
  end
end
