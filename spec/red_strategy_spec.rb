# encoding: UTF-8
require 'spec_helper'

describe Pacman::RedStrategy do
  before do
    @window = FakeWindow.new
    @red_strategy = Pacman::RedStrategy.new()
  end

  it 'should change state' do
    player = Pacman::Player.new(@window)
    player.warp(8, 8)
    row, col = 100, 100
    a = [[0] * row] * col

    @red_strategy.tick(a, player, nil)
    @red_strategy.state.should == Pacman::RedStrategy::SCATTER
    329.times do
      @red_strategy.tick(a, player, nil)
    end
    @red_strategy.state.should == Pacman::RedStrategy::CHASE
    1650.times do
      @red_strategy.tick(a, player, nil)
    end
    @red_strategy.state.should == Pacman::RedStrategy::SCATTER
  end

  after do
    @window.close
  end
end
