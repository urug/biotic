# frozen_string_literal: true

# class WorldState
class WorldState < String
  # @return [Integer] the width of the world
  attr_reader :width
  # @return [Integer] the heigh of the world
  attr_reader :height

  # raised when a dimension is invalid
  class InvalidDimension < StandardError; end
  # raised when a initial state is invalid
  class InvalidState < StandardError; end
  # raised when a position is outside of the world
  class InvalidPosition < StandardError; end

  # @param width [Integer]
  # @param height [Integer]
  # @param init [String]
  def initialize(width:, height:, init: nil)
    raise InvalidDimension if width < 1 || height < 1
    raise InvalidState if init && width * height != init.length

    init ? super(init) : super(' ' * (width * height))
    @width = width
    @height = height
  end

  # true if the cell at position is live and false if it is dead
  # @param pos [Integer]
  # @return [Boolean]
  def live?(pos)
    valid_position?(pos)
    self[pos] && self[pos] != ' '
  end

  # true if the cell at position is dead and false if it is live
  # @param pos [Integer]
  # @return [Boolean]
  def dead?(pos)
    valid_position?(pos)
    self[pos] && self[pos] == ' '
  end

  # the player character for a live cell, or space if dead cell
  # @param pos [Integer]
  # @return [String]
  def p(pos)
    valid_position?(pos)
    return if self[pos] == ' '
    self[pos]
  end
  alias player p

  # the position northwest (up, left) of the position
  # @param pos [Integer]
  # @return [Integer]
  def nw(pos)
    valid_position?(pos)
    w(n(pos))
  end
  alias northwest nw

  # the position north (up) of the position
  # @param pos [Integer]
  # @return [Integer]
  def n(pos)
    valid_position?(pos)
    return pos + @width * (@height - 1) if (pos / @width).zero? # top edge case
    pos - @width
  end
  alias north n

  # The position northest (up, right) of the position
  # @param pos [Integer]
  # @return [Integer]
  def ne(pos)
    valid_position?(pos)
    e(n(pos))
  end
  alias northeast ne

  # The position west (left) of the position
  # @param pos [Integer]
  # @return [Integer]
  def w(pos)
    valid_position?(pos)
    return pos - 1 + @width if (pos % @width).zero? # left edge case
    pos - 1
  end
  alias west w

  # The position east (right) of the position
  # @param pos [Integer]
  # @return [Integer]
  def e(pos)
    valid_position?(pos)
    return pos + 1 - @width if (pos % @width) == @width - 1 # right edge case
    pos + 1
  end
  alias east e

  # The position southeast (down, left) of the position
  # @param pos [Integer]
  # @return [Integer]
  def sw(pos)
    valid_position?(pos)
    w(s(pos))
  end
  alias southwest sw

  # The position south (down) of the position
  # @param pos [Integer]
  # @return [Integer]
  def s(pos)
    valid_position?(pos)
    return pos % @width if (pos / @width) == @height - 1 # bottom edge case
    pos + @width
  end
  alias south s

  # The position southeast (down, left) of the position
  # @param pos [Integer]
  # @return [Integer]
  def se(pos)
    valid_position?(pos)
    e(s(pos))
  end
  alias southeast se

  # rubocop:disable Layout/AlignArray
  # rubocop:disable Layout/ExtraSpacing
  # rubocop:disable Metrics/AbcSize
  # I like how this reads as written, rubocop

  # The player chars or emptiness around the position (includes position)
  # @param pos [Integer] a position in the world
  # @return [Array<String>]
  def neighborhood(pos)
    valid_position?(pos)

    [
      self[nw(pos)], self[n(pos)], self[ne(pos)],
       self[w(pos)],  self[pos],   self[e(pos)],
      self[sw(pos)], self[s(pos)], self[se(pos)]
    ]
  end
  # rubocop:enable all

  # The player char of this position in the next state; space if dead
  # @param pos [Integer]
  # @return [String]
  def next(pos)
    valid_position?(pos)
    nhood = neighborhood(pos)

    return handle_dead(nhood) if p(pos) == ' '

    # overpopulation
    return ' ' if nhood.count(' ') < 5
    # underpopulation
    return ' ' if nhood.count(' ') > 6

    return handle_two_neighbors(nhood) if nhood.count(' ') == 6

    handle_three_neighbors(nhood)
  end

  private

  def valid_position?(pos)
    raise InvalidPosition if pos.negative?
    raise InvalidPosition if pos >= length
  end

  def majority(neighborhood)
    neighborhood.reject { |i| i == ' ' }.max_by { |i| neighborhood.count(i) }
  end

  def handle_dead(neighborhood)
    # dead stays dead unless 3 live neighbors
    return ' ' unless neighborhood.count(' ') == 6
    # no clear winner, no reproduction
    return ' ' if neighborhood.uniq.count == 4

    majority(neighborhood)
  end

  def handle_two_neighbors(neighborhood)
    # two neighbors are different, stay the same
    return neighborhood[4] if neighborhood.uniq.count == 4

    majority(neighborhood)
  end

  def handle_three_neighbors(neighborhood)
    # no majority, stay the same
    return neighborhood[4] if neighborhood.uniq.count == 5
    # have an ally, stay the same
    return neighborhood[4] if neighborhood.count(neighborhood[4]) > 1

    majority(neighborhood)
  end
end
