# frozen_string_literal: true

# class Rando
class Rando
  include Morphogen

  def moves(world_state)
    [rand(world_state.size), rand(world_state.size)]
  end
end
