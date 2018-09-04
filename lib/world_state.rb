# frozen_string_literal: true

# class WorldState
class WorldState < String
  attr_reader :width
  attr_reader :height

  class BadState < StandardError; end

  # @param width [Integer] how wide the world is
  # @param height [Integer] how high the world is
  # @param state [String] an initial state
  def initialize(width:, height:, state: nil)
    raise BadState if state && width * height != state.length

    state ? super(state) : super(' ' * (width * height))
    @width = width
    @height = height
  end

  # @param pos [Integer] a position in the world
  # @return [Boolean] true if the cell at position is live and false if it is dead
  def live?(pos)
    return if pos.negative?
    self[pos] && self[pos] != ' '
  end

  # @param pos [Integer] a position in the world
  # @return [Boolean] true if the cell at position is dead and false if it is live
  def dead?(pos)
    return if pos.negative?
    self[pos] && self[pos] == ' '
  end

  # @param pos [Integer] a position in the world
  # @return [String] the owner character for a live cell, or space if dead cell
  def o(pos)
    return if pos.negative?
    return if self[pos] == ' '
    self[pos]
  end
  alias owner o

  # @param position [Integer] a position in the world
  # @return [Integer] the position northwest (up, left) of the position
  def nw(pos)
    w(n(pos))
  end
  alias northwest nw

  # @param pos [Integer] a position in the world
  # @return [Integer] the position north (up) of the position
  def n(pos)
    return pos + @width * (@height - 1) if (pos / @width).zero? # top edge case
    pos - @width
  end
  alias north n

  # @param pos [Integer] a position in the world
  # @return [Integer] the position northest (up, right) of the position
  def ne(pos)
    e(n(pos))
  end
  alias northeast ne

  # @param pos [Integer] a position in the world
  # @return [Integer] the position west (left) of the position
  def w(pos)
    return pos - 1 + @width if (pos % @width).zero?
    pos - 1
  end
  alias west w

  # @param pos [Integer] a position in the world
  # @return [Integer] the position east (right) of the position
  def e(pos)
    return pos + 1 - @width if (pos % @width) == @width - 1 # right edge case
    pos + 1
  end
  alias east e

  # @param pos [Integer] a position in the world
  # @return [Integer] the position southeast (down, left) of the position
  def sw(pos)
    w(s(pos))
  end
  alias southwest sw

  # @param pos [Integer] a position in the world
  # @return [Integer] the position south (down) of the position
  def s(pos)
    return pos % @width if (pos / @width) == @height - 1 # bottom edge case
    pos + @width
  end
  alias south s

  # @param pos [Integer] a position in the world
  # @return [Integer] the position southeast (down, left) of the position
  def se(pos)
    e(s(pos))
  end
  alias southeast se

  # @param position [Integer] a position in the world
  # @return [Array<String>] the owner chars or emptiness around the position and what is
  # in that position
  # rubocop:disable Layout/AlignArray
  # rubocop:disable Layout/ExtraSpacing
  # rubocop:disable Metrics/AbcSize
  # I like how this is written, rubocop
  def neighborhood(pos)
    return [] unless valid_position?(pos)

    [
      self[nw(pos)], self[n(pos)], self[ne(pos)],
       self[w(pos)],  self[pos],   self[e(pos)],
      self[sw(pos)], self[s(pos)], self[se(pos)]
    ]
  end
  # rubocop:enable all

  private

  def valid_position?(pos)
    return if pos.negative?
    return if pos >= length
    true
  end
end
