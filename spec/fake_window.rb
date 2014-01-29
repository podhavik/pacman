# encoding: UTF-8
require 'rubygems'
require 'gosu'

# fake game window for testing
class FakeWindow < Gosu::Window

  def initialize
    super(16 * 28, 16 * 36, false, 18)
  end

  def update
  end

  def draw
  end

  def self.run
    new.show
  end
end
