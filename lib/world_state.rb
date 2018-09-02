# frozen_string_literal: true

# class WorldState
class WorldState < String
  attr_reader :width
  attr_reader :height

  # @param width [Integer] how wide the world is
  # @param height [Integer] how high the world is
  # @param state [String] an initial state
  def initialize(width:, height:, state: nil)
    state ? super(state) : super(' ' * (width * height))
    @width = width
    @height = height
  end

  # @param position [Integer] a position in the world
  # @return [Boolean] true if the cell at position is live and false if it is dead
  def live?(position)
    return if position.negative?
    self[position] && self[position] != ' '
  end

  # @param position [Integer] a position in the world
  # @return [Boolean] true if the cell at position is dead and false if it is live
  def dead?(position)
    return if position.negative?
    self[position] && self[position] == ' '
  end

  # @param position [Integer] a position in the world
  # @return [String] the team character for a live cell, or space if dead cell
  def team(position)
    return if position.negative?
    return if self[position] == ' '
    self[position]
  end

  # @param position [Integer] a position in the world
  # @return [Array<String>] the team chars or emptiness around the position and what is
  # in that position
  def neighborhood(position)
    return [] if position.negative?
    return [] if position >= length

    x = position % @width
    y = position / @width
    [

    ]
  end
end
