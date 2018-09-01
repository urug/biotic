# frozen_string_literal: true

# class World
class World
  attr_reader :state

  def initialize(width:, height:, state: nil)
    @width  = width
    @height = height
    @state  = state || ' ' * (width * height)
  end

  def live?(position)
    return if position.negative?
    @state[position] && @state[position] != ' '
  end

  def dead?(position)
    return if position.negative?
    @state[position] && @state[position] == ' '
  end

  def team(position)
    return if position.negative?
    return if @state[position] == ' '
    @state[position]
  end

  def iterate
  end
end
