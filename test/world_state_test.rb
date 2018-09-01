# frozen_string_literal: true

require_relative 'test_helper'

describe WorldState do
  describe '#live?' do
    it 'must return true if the cell at `position` is alive' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.live?(0).must_equal true
    end

    it 'must return false if the cell at `position` is dead' do
      world = WorldState.new(width: 1, height: 1, state: ' ')
      world.live?(0).must_equal false
    end

    it 'must return nil for positions outside of the world' do
      world = WorldState.new(width: 1, height: 1, state: ' ')
      world.live?(1).must_be_nil
    end
  end

  describe '#dead?' do
    it 'must return true if the cell at `position` is dead' do
      world = WorldState.new(width: 1, height: 1, state: ' ')
      world.dead?(0).must_equal true
    end

    it 'must return false if the cell at `position` is alive' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.dead?(0).must_equal false
    end

    it 'must return nil for positions outside of the world' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.dead?(-1).must_be_nil
    end
  end

  describe '#team' do
    it 'must return the team character for a position' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.team(0).must_equal 'X'
    end

    it 'must return nil if there is no team character at position' do
      world = WorldState.new(width: 1, height: 1)
      world.team(0).must_be_nil
    end

    it 'must return nil if the position is outside of the world' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.team(-1).must_be_nil
    end
  end

  describe '#neighborhood' do
    it 'must return [] for a position before the beginning' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.neighborhood(-1).must_equal []
    end

    it 'must return [] for a position beyond the end' do
      world = WorldState.new(width: 1, height: 1, state: 'X')
      world.neighborhood(1).must_equal []
    end

    it 'must return the correct neighborhood for any position' do
      # ABCD
      # EFGH
      # IJKL
      world = WorldState.new(width: 4, height: 3, state: 'ABCDEFGHIJKL')
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
end
