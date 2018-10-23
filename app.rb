# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'ruby2d'
require './lib/morphogen'
require './lib/world'
Dir['./morphogens/*.rb'].each { |file| require file }

FONT        = 'resources/Lato.ttf'
FONT_SIZE   = 24
WIDTH       = 120
HEIGHT      = 90
CELL_SIZE   = 8
GUTTER      = 24
SIDEBAR     = 240
FULL_HEIGHT = HEIGHT * CELL_SIZE
FULL_WIDTH  = WIDTH * CELL_SIZE + GUTTER + SIDEBAR

@world = World.new(width: WIDTH, height: HEIGHT)

@morphogens = Morphogen.classes.shuffle.each_with_index.each_with_object({}) do |(klass, index), hash|
  char = (65 + index).chr
  hash[char] = klass.new(char: char)
  hash
end
@morphogens_enumerator = @morphogens.cycle

# starting positions

def make_moves
  morphogen = @morphogens_enumerator.next[1]
  moves = morphogen.moves(@world.state)
  @world.set_player(player: morphogen.char, pos: moves[0])
  @world.set_player(player: morphogen.char, pos: moves[1])
end

def render_scoreboard
  y = 0
  default = { size: FONT_SIZE, font: FONT, x: FULL_WIDTH - SIDEBAR }
  @morphogens.each do |char, morphogen|
    score = @world.player_score(char)
    Text.new(default.merge(y: y, text: morphogen.name, color: morphogen.color))
    Text.new(default.merge(y: y + FONT_SIZE, text: "score: #{score}", color: 'white'))
    y += FONT_SIZE * 3
  end
end

set title: 'Biotic', width: FULL_WIDTH, height: FULL_HEIGHT

def render_world
  state = @world.state
  state.each_char.each_with_index do |char, pos|
    next if state.dead?(pos)
    x = pos % WIDTH
    y = pos / WIDTH
    Square.new(
      x: x * CELL_SIZE, y: y * CELL_SIZE, size: CELL_SIZE, color: @morphogens[char].color
    )
  end
end

def redraw
  clear
  make_moves
  render_world
  render_scoreboard
  @world.iterate
end

update do
  # redraws every 2 seconds (ish)
  redraw if (0.5 * (get :frames).to_i % (get :fps).to_i).zero?
end
show
