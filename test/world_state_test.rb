# frozen_string_literal: true

require_relative 'test_helper'

describe WorldState do
  describe '#initialize' do
    it 'must raise for invalid dimensions' do
      -> { WorldState.new(width: 0, height: 1) }.must_raise WorldState::InvalidDimension
      -> { WorldState.new(width: 1, height: 0) }.must_raise WorldState::InvalidDimension
    end

    it 'must raise for an invalid initial state' do
      lambda do
        WorldState.new(width: 1, height: 1, init: '12')
      end.must_raise WorldState::InvalidState
    end
  end

  describe '#live?' do
    it 'must return true if the cell at `position` is alive' do
      world = WorldState.new(width: 1, height: 1, init: 'X')
      world.live?(0).must_equal true
    end

    it 'must return false if the cell at `position` is dead' do
      world = WorldState.new(width: 1, height: 1, init: ' ')
      world.live?(0).must_equal false
    end

    it 'must raise for positions outside of the world' do
      world = WorldState.new(width: 1, height: 1, init: ' ')
      -> { world.live?(1) }.must_raise WorldState::InvalidPosition
    end
  end

  describe '#dead?' do
    it 'must return true if the cell at `position` is dead' do
      world = WorldState.new(width: 1, height: 1, init: ' ')
      world.dead?(0).must_equal true
    end

    it 'must return false if the cell at `position` is alive' do
      world = WorldState.new(width: 1, height: 1, init: 'X')
      world.dead?(0).must_equal false
    end

    it 'must raise for positions outside of the world' do
      world = WorldState.new(width: 1, height: 1, init: 'X')
      -> { world.dead?(-1) }.must_raise WorldState::InvalidPosition
    end
  end

  describe '#player' do
    it 'must return the player character for a position' do
      world = WorldState.new(width: 1, height: 1, init: 'X')
      world.player(0).must_equal 'X'
    end

    it 'must return nil if there is no player character at position' do
      world = WorldState.new(width: 1, height: 1)
      world.player(0).must_be_nil
    end

    it 'must raise if the position is outside of the world' do
      world = WorldState.new(width: 1, height: 1, init: 'X')
      -> { world.player(-1) }.must_raise WorldState::InvalidPosition
    end
  end

  # 012
  # 345
  # 678
  describe '#north' do
    it 'must return the position of the cell above' do
      world = WorldState.new(width: 3, height: 3, init: '012345678')
      world.north(4).must_equal 1
    end

    it 'must wrap from top edge to bottom' do
      world = WorldState.new(width: 3, height: 3, init: '012345678')
      world.north(1).must_equal 7
    end
  end

  describe '#south' do
    it 'must return the position of the cell below' do
      world = WorldState.new(width: 3, height: 3, init: '012345678')
      world.south(4).must_equal 7
    end

    it 'must wrap from bottom edge to top' do
      world = WorldState.new(width: 3, height: 3, init: '012345678')
      world.south(7).must_equal 1
    end
  end

  describe '#east' do
    it 'must return the position of the cell to the right' do
      world = WorldState.new(width: 3, height: 3, init: '012345678')
      world.east(4).must_equal 5
    end

    it 'must wrap from right to left' do
      world = WorldState.new(width: 3, height: 3, init: '012345678')
      world.east(5).must_equal 3
    end
  end

  describe '#west' do
    it 'must return the position of the cell to the left' do
      world = WorldState.new(width: 3, height: 3, init: '012345678')
      world.west(4).must_equal 3
    end

    it 'must wrap from left to right' do
      world = WorldState.new(width: 3, height: 3, init: '012345678')
      world.west(3).must_equal 5
    end
  end

  describe '#neighborhood' do
    it 'must raise for a position before the beginning' do
      world = WorldState.new(width: 1, height: 1, init: 'X')
      -> { world.neighborhood(-1) }.must_raise WorldState::InvalidPosition
    end

    it 'must raise for a position beyond the end' do
      world = WorldState.new(width: 1, height: 1, init: 'X')
      -> { world.neighborhood(1) }.must_raise WorldState::InvalidPosition
    end

    # ABCD
    # EFGH
    # IJKL
    it 'must return the correct neighborhood for any position' do
      world = WorldState.new(width: 4, height: 3, init: 'ABCDEFGHIJKL')
      world.neighborhood(0).must_equal %w[L I J D A B H E F]
      world.neighborhood(1).must_equal %w[I J K A B C E F G]
      world.neighborhood(3).must_equal %w[K L I C D A G H E]
      world.neighborhood(4).must_equal %w[D A B H E F L I J]
      world.neighborhood(5).must_equal %w[A B C E F G I J K]
      world.neighborhood(7).must_equal %w[C D A G H E K L I]
      world.neighborhood(8).must_equal %w[H E F L I J D A B]
      world.neighborhood(10).must_equal %w[F G H J K L B C D]
      world.neighborhood(11).must_equal %w[G H E K L I C D A]
    end
  end

  describe '#next' do
    it 'must return a space for an empty neighborhood' do
      world = WorldState.new(width: 3, height: 3, init: '         ')
      world.next(4).must_equal ' '
    end

    it 'must return a space for a live cell with only one neighbor' do
      world = WorldState.new(width: 3, height: 3, init: '    AB   ')
      world.next(4).must_equal ' '
    end

    it 'must return the same character with two different neighbors' do
      world = WorldState.new(width: 3, height: 3, init: '   ABC   ')
      world.next(4).must_equal 'B'
    end

    it 'must return the neighbor character outnumbered by two neighbors' do
      world = WorldState.new(width: 3, height: 3, init: '   ABA   ')
      world.next(4).must_equal 'A'
    end

    it 'must return the neighbor character if outnumbered and has three neighbors' do
      world = WorldState.new(width: 3, height: 3, init: ' A ABC   ')
      world.next(4).must_equal 'A'
    end

    it 'must return the same if not outnumbered and has three neighbors' do
      world = WorldState.new(width: 3, height: 3, init: ' A ABB   ')
      world.next(4).must_equal 'B'
    end

    it 'must die of overpopulation with four neighbors' do
      world = WorldState.new(width: 3, height: 3, init: ' A ABBA  ')
      world.next(4).must_equal ' '
    end

    it 'must die of overpopulation with five neighbors' do
      world = WorldState.new(width: 3, height: 3, init: 'AA ABBA  ')
      world.next(4).must_equal ' '
    end

    it 'must die of overpopulation with six neighbors' do
      world = WorldState.new(width: 3, height: 3, init: 'AAAABBA  ')
      world.next(4).must_equal ' '
    end

    it 'must die of overpopulation with seven neighbors' do
      world = WorldState.new(width: 3, height: 3, init: 'AAAABBAA ')
      world.next(4).must_equal ' '
    end

    it 'must die of overpopulation with seven neighbors' do
      world = WorldState.new(width: 3, height: 3, init: 'AAAABBAAA')
      world.next(4).must_equal ' '
    end
  end
end
