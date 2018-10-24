# frozen_string_literal: true

# class Rando
class Simple
  include Morphogen

  def color
    '#4FC1E9'
  end

  def seed
    [
      '   XXX  ',
      '        ',
      '        ',
      '        ',
      '    X   ',
      '        ',
      '   XXX  ',
      '    X   ',
    ]
  end

  def moves(world_state)
    # find the position of the first cell that we own
    pos = world_state.index(char)
    # randomly choose two neighboring positions to play
    [
      world_state.n(pos),
      world_state.ne(pos),
      world_state.e(pos),
      world_state.se(pos),
      world_state.s(pos),
      world_state.sw(pos),
      world_state.w(pos),
      world_state.nw(pos)
    ].sample(2)
  end
end
