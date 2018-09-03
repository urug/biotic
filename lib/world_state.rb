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
  # @return [String] the owner character for a live cell, or space if dead cell
  def o(position)
    return if position.negative?
    return if self[position] == ' '
    self[position]
  end
  alias owner o

  def nw(pos)
    w(n(pos))
  end
  alias northwest nw

  def n(pos)
  end
  alias north n

  def ne(pos)
    e(n(pos))
  end
  alias northeast ne

  def w(pos)
  end
  aliast west w

  def e(pos)
  end
  alias east e

  def sw(pos)
    w(s(pos))
  end
  alias southwest sw

  def s(pos)
  end
  alias south s

  def se(pos)
    e(s(pos))
  end
  alias southeast se

  # @param position [Integer] a position in the world
  # @return [Array<String>] the owner chars or emptiness around the position and what is
  # in that position
  def neighborhood(pos)
    return [] unless valid_position?(pos)

    [
      nw(pos), n(pos), ne(pos),
       w(pos), o(pos), e(pos), # rubocop:disable Layout/AlignArray
      sw(pos), s(pos), se(pos)
    ]
  end

  private

  def valid_position?(pos)
    return if pos.negative?
    return if pos >= length
    true
  end
end
