# frozen_string_literal: true

# module Morphogen
module Morphogen
  class << self
    attr_reader :classes

    def included(klass)
      @classes ||= []
      @classes << klass
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
