# frozen_string_literal: true

require_relative 'world_state'

# class World
class World
  def initialize(width:, height:, init: nil)
    @state = WorldState.new(width: width, height: height, state: init)
  end

  def state
    @state.dup.freeze
  end

  def set_owner(owner: ' ', pos:)
    @state[pos] = owner
  end

  def iterate
    marked_for_death = []
    marked_for_life = []

    @state.each_char.each_with_index do |curr, pos|
      nxt = @state.next(pos)
      next if curr == nxt

      marked_for_death << pos if curr != ' ' && nxt == ' '
      marked_for_life << {owner: nxt, pos: pos } if nxt != ' '
    end

    marked_for_death.each { |pos| set_owner(owner: ' ', pos: pos) }
    marked_for_life.each { |pair| set_owner(owner: pair[:owner], pos: pair[:pos]) }
  end
end
