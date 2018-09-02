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

  # @param char [String] the character assigned to this class by the game and how the
  # world will represent this class in the game
  def initialize(char:)
    @char = char
  end

  # @return [String] the name use to represent this class
  def name
    self.class.to_s
  end

  # @return [String] a hex color string used to represent this class. It is recommended
  # that you overwrite this method
  def color
    '#' + %w[0 3 6 9 C F].shuffle.join
  end

  # @return [String] an 8x8 block representing how the starting cells for this class will
  # be initialized into the world. It is recommended that you overwrite this method
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
