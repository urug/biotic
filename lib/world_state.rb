# frozen_string_literal: true

# class WorldState
class WorldState < String
  attr_reader :width
  attr_reader :height

  def initialize(width:, height:, state: nil)
    state ? super(state) : super(' ' * (width * height))
    @width = width
    @height = height
  end

  def live?(position)
    return if position.negative?
    self[position] && self[position] != ' '
  end

  def dead?(position)
    return if position.negative?
    self[position] && self[position] == ' '
  end

  def team(position)
    return if position.negative?
    return if self[position] == ' '
    self[position]
  end
end
