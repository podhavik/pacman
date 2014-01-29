# encoding: UTF-8
require 'spec_helper'

describe Pacman::GameObject do
  before do
    @obj = Pacman::GameObject.new
    
  end

  it 'should warp' do
    @obj.warp(12, 13)
    @obj.x.should == 12
    @obj.y.should == 13
    @obj.warp(20, 18)
    @obj.x.should == 20
    @obj.y.should == 18
  end

  it 'should return grid coordinates' do
    @obj.warp(20, 18)
    @obj.grid_x.should == 1
    @obj.grid_y.should == 1
    @obj.grid_pos.x.should == 1
    @obj.grid_pos.y.should == 1
  end
end
