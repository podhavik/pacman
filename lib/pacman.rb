# Pacman package
module Pacman
  require_relative "pacman/version"
  require_relative 'pacman/GameWindow.rb'
  require_relative 'pacman/Game.rb'
  require_relative 'pacman/GameObject.rb'
  require_relative 'pacman/Block.rb'
  require_relative 'pacman/Player.rb'
  require_relative 'pacman/Point.rb'
  require_relative 'pacman/Screen.rb'
  require_relative 'pacman/Red.rb'
  require_relative 'pacman/Pink.rb'
  require_relative 'pacman/Orange.rb'
  require_relative 'pacman/Cyan.rb'
  require_relative 'pacman/Coordinate.rb'
  ROOT_PATH = File.dirname(File.dirname(__FILE__)) + '/'
end
