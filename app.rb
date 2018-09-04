# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'ruby2d'
require './lib/morphogen'
Dir['./morphogens/*.rb'].each { |file| require file }

# https://freemusicarchive.org/music/Christian_Bjoerklund/
MUSIC       = 'resources/Hallon.mp3'
FONT        = 'resources/Lato.ttf'
FONT_SIZE   = 24
WIDTH       = 120
HEIGHT      = 90
CELL_SIZE   = 8
GUTTER      = 24
SIDEBAR     = 240
FULL_HEIGHT = HEIGHT * CELL_SIZE
FULL_WIDTH  = WIDTH * CELL_SIZE + GUTTER + SIDEBAR

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
render_scoreboard(Morphogen.classes.map do |k|
  char = char.succ
  k.new(char: char)
end)

show

