# encoding: UTF-8
require 'spec_helper'

describe Pacman::Red do
  before do
    @win = FakeWindow.new
    @red = Pacman::Red.new(@win)
  end

  it 'should kill pacman on same xy' do
    player = Pacman::Player.new(@win)
    player.warp(8, 8)
    @red.warp(8, 8)
    @red.kill_pacman(player)
    player.alive?.should == false
  end

  it 'shouldnt kill pacman on different xy' do
    player = Pacman::Player.new(@win)
    player.warp(8, 8)
    @red.warp(20, 20)
    @red.kill_pacman(player)
    player.alive?.should == true
  end

  it 'should move' do
    player = Pacman::Player.new(@win)
    player.warp(8, 8)
    row, col = 10, 10
    a = [[0] * row] * col
    @red.warp(20, 0)
    @red.move(a, player, nil)
  end

end
