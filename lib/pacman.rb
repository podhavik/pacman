# Pacman package
module Pacman
  require_relative "pacman/version"
  require_relative 'pacman/game_window.rb'
  require_relative 'pacman/game.rb'
  require_relative 'pacman/game_object.rb'
  require_relative 'pacman/block.rb'
  require_relative 'pacman/player.rb'
  require_relative 'pacman/point.rb'
  require_relative 'pacman/screen.rb'
  require_relative 'pacman/red.rb'
  require_relative 'pacman/pink.rb'
  require_relative 'pacman/orange.rb'
  require_relative 'pacman/cyan.rb'
  require_relative 'pacman/coordinate.rb'
  require_relative 'pacman/red_strategy.rb'
  require_relative 'pacman/pink_strategy.rb'
  require_relative 'pacman/cyan_strategy.rb'
  require_relative 'pacman/orange_strategy.rb'
  ROOT_PATH = File.dirname(File.dirname(__FILE__)) + '/'
end
