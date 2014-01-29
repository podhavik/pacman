# encoding: UTF-8
require 'spec_helper'

describe Pacman::Game do
  before do
    @window = FakeWindow.new
    @game = Pacman::Game.new(@window, {})
  end
  
  it 'should load map' do
    path = File.dirname(__FILE__) + '/lvl.txt'
    map = File.foreach(path).map { |line| line.split(' ') }
    @game.points.clear
    @game.ghosts.clear
    @game.load_map(@window, map)
    @game.player.grid_x.should == 2
    @game.player.grid_y.should == 23
    @game.points.count.should == 322
    @game.ghosts.count.should == 4
  end
  
  after do
    @window.close
  end
end
