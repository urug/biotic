require 'rubygems'
require 'bundler/setup'
require 'ruby2d'
require './lib/morphogen'
Dir['./morphogens/*.rb'].each { |file| require file }

WIDTH       = 120
HEIGHT      = 90
CELL_SIZE   = 8
GUTTER      = 24
SIDEBAR     = 240
FULL_HEIGHT = HEIGHT * CELL_SIZE
FULL_WIDTH  = WIDTH * CELL_SIZE + GUTTER + SIDEBAR
FONT        = 'resources/Lato.ttf'.freeze
FONT_SIZE   = 24

def render_scoreboard(morphogens)
  y = 0
  default = { size: FONT_SIZE, font: FONT, x: FULL_WIDTH - SIDEBAR }
  morphogens.each do |morphogen|
    Text.new(default.merge(y: y, text: morphogen.name, color: morphogen.color))
    Text.new(default.merge(y: y + FONT_SIZE, text: 'score: 14', color: 'white'))
    y += FONT_SIZE * 3
  end
end

set title: 'Biotic', width: FULL_WIDTH, height: FULL_HEIGHT
char = 'A'
render_scoreboard(Morphogen.children.map do |k|
  k.new(world_height: HEIGHT, world_width: WIDTH, char: char.succ!)
end)

show

