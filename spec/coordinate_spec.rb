# encoding: UTF-8
require 'spec_helper'

describe Pacman::Coordinate do
  before do
    @coord = Pacman::Coordinate.new(10, 20)
  end

  it 'should return a filled instance' do
    @coord.x.should == 10
    @coord.y.should == 20
  end

  it 'should have neighbors' do
    @coord.neighbor(Pacman::LEFT).x.should == 9
    @coord.neighbor(Pacman::LEFT).y.should == 20
    
    @coord.neighbor(Pacman::RIGHT).x.should == 11
    @coord.neighbor(Pacman::RIGHT).y.should == 20
    
    @coord.neighbor(Pacman::UP).x.should == 10
    @coord.neighbor(Pacman::UP).y.should == 19
    
    @coord.neighbor(Pacman::DOWN).x.should == 10
    @coord.neighbor(Pacman::DOWN).y.should == 21
  end

  it 'should calculate manhatan distance' do
    @coord.distance(Pacman::Coordinate.new(0, 0)).should == 30
  end
end
