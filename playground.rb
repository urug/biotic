require 'rubygems'
require 'bundler/setup'
require 'ruby2d'
Dir['./lib/*.rb'].each { |file| require file }

CELL_SIZE = 16
WIDTH = 48
HEIGHT = 32
FULL_WIDTH = WIDTH * CELL_SIZE
FULL_HEIGHT = HEIGHT * CELL_SIZE
# https://bootflat.github.io/documentation.html
BACKGROUND_COLOR = '#434A54'
GRID_COLOR = '#656D78'
COLORS = { 'A' => '#A0D468', 'B' => '#FC6E51' }

set title: 'Playground', width: FULL_WIDTH, height: FULL_HEIGHT,
    background: BACKGROUND_COLOR

@world = World.new(width: WIDTH, height: HEIGHT)
@toggle = false

def draw_grid
  WIDTH.times do |x|
    Line.new x1: x * CELL_SIZE, x2: x * CELL_SIZE, y1: 0, y2: FULL_HEIGHT,
      color: GRID_COLOR
  end
  HEIGHT.times do |y|
    Line.new x1: 0, x2: FULL_WIDTH, y1: y * CELL_SIZE, y2: y * CELL_SIZE,
      color: GRID_COLOR
  end
end

def draw_world
  state = @world.state
  state.each_char.each_with_index do |char, pos|
    x = pos % WIDTH
    y = pos / WIDTH
    if state.live?(pos)
      Square.new x: x * CELL_SIZE, y: y * CELL_SIZE, size: CELL_SIZE,
        color: COLORS[state.owner(pos)]
    end
  end
end

def redraw
  clear
  draw_grid
  draw_world
end

def iterate
  @world.iterate
end

on :mouse_up do |evt|
  position = WIDTH * (evt.y / CELL_SIZE) + (evt.x / CELL_SIZE)
  state = @world.state
  if state.live?(position)
    @world.set_owner(owner: ' ', pos: position)
  else
    @world.set_owner(owner: 'A', pos: position) if evt.button == :left
    @world.set_owner(owner: 'B', pos: position) if evt.button == :right
  end
end

on :key_up do |evt|
  @toggle = !@toggle if evt.key == 'space'
end

update do
  redraw
  iterate if @toggle && (0.5 * (get :frames).to_i % (get :fps).to_i).zero?
end

show
