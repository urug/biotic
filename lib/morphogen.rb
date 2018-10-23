# frozen_string_literal: true

# module Morphogen
module Morphogen
  class << self
    # An array of the classes that have included this module
    # @return [Array<Class>]
    attr_reader :classes

    # @param klass [Class]
    def included(klass)
      @classes ||= []
      @classes << klass
    end
  end

  attr_reader :char

  # Don't overwrite this method
  # The character assigned to this class by the game and how the world will represent
  # this class in the game
  # @param char [String]
  def initialize(char:)
    @char = char
  end

  # You can overwrite this method
  # The name use to represent this class
  # @return [String]
  def name
    self.class.to_s
  end

  # You should overwrite this method.
  # A hex color string used to represent this class.
  # @return [String]
  def color
    @color ||= '#' + %w[0 3 6 9 C F].shuffle.join
  end

  # You should overwrite this method
  # Given a current world state, return the two empty
  # positions you'd like to move
  # @param world_state [WorldState]
  # @return [Array<Integer>]
  def moves(world_state)
    []
  end
end
