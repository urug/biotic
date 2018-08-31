#
# Base class for creating entities in the game
#
module Morphogen
  class << self
    attr_reader :children

    def included(klass)
      @children = (@children || []).push(klass)
    end
  end

  def initialize(world_width:, world_height:, char:)
    @width  = world_width
    @height = world_height
    @char   = char
  end

  def name
    self.class.to_s
  end

  def color
    '#' + %w[0 3 6 9 C F].shuffle.join
  end

  def seed
    [
      'X X X X ',
      ' X X X X',
      'X X X X ',
      ' X X X X',
      'X X X X ',
      ' X X X X',
      'X X X X ',
      ' X X X X',
    ]
  end

  def moves(world_state)
  end
end
