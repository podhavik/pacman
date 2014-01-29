# encoding: UTF-8
# pacman module
module Pacman
  require 'rubygems'
  require 'gosu'
  # define order of rendering layers
  module ZOrder
    BACKGROUND, PLAYER, UI = *0..3
  end

  # game window implements game loop
  class GameWindow < Gosu::Window
    attr_reader :fps
    def init_game(opts)
      @game = Game.new(self, opts)
      @screen = Screen.new(self, @game)
      @last_millis =  Gosu.milliseconds
      @fps = 0
      path = ROOT_PATH + '/media/Intro.ogg'
      @intro = Gosu::Sample.new(self, path)
      @intro.play
      @started = false
      # @started = true
      @count = 0
    end

    def initialize(opts)
      super(16 * 28, 16 * 36, false, 18)
      self.caption = 'Gosu Pac-man'
      init_game(opts)
    end

    def update
      if @started == true
        if @game.win == false && @game.lose == false
          if button_down?(Gosu::KbLeft) || button_down?(Gosu::GpLeft)
            @game.pressed_left
          end
          if button_down?(Gosu::KbRight) || button_down?(Gosu::GpRight)
            @game.pressed_right
          end
          if button_down?(Gosu::KbUp) || button_down?(Gosu::GpButton0)
            @game.pressed_up
          end
          if button_down?(Gosu::KbDown) || button_down?(Gosu::GpButton0)
            @game.pressed_down
          end

          @game.update

          millis = Gosu.milliseconds
          @fps = millis - @last_millis
          @fps = (1000 / @fps)
          @last_millis = millis
        end
      else
        @count += 1
        if @count == 260
          @started = true
          @count = 0
        end
      end
    end

    def draw
      @screen.draw
    end

    def button_down(id)
      close if id == Gosu::KbEscape

      if id == Gosu::KbReturn
        init_game unless @game.win == false && @game.lose == false
      end
    end

    def self.run(opts)
      new(opts).show
    end
  end
end
