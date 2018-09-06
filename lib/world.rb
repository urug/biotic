# frozen_string_literal: true

require_relative 'world_state'

# class World
class World
  def initialize(width:, height:, init: nil)
    @state = WorldState.new(width: width, height: height, state: init)
  end

  def clear
    @state = WorldState.new(width: @state.width, height: @state.height)
  end

  def state
    @state.dup.freeze
  end

  def set_player(player: ' ', pos:)
    @state[pos] = player
  end

  def iterate
    @state.each_char.each_with_index.each_with_object([]) do |(curr, pos), memo|
      nxt = @state.next(pos)
      curr == nxt ? memo : memo << [nxt, pos]
    end.each do |char, pos|
      set_player(player: char, pos: pos)
    end
  end
end
