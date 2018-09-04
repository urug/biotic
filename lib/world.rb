# frozen_string_literal: true

require 'world_state'

# class World
class World
  def initialize(width:, height:, init: nil)
    @state = WorldState.new(width: width, height: height, state: init)
  end

  def iterate; end
end
