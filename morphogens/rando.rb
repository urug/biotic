# frozen_string_literal: true

# class Rando
class Rando
  include Morphogen


  # choose two random positions in the world
  def moves(world_state)
    [rand(world_state.size), rand(world_state.size)]
  end
end
