class World
  attr_reader :state

  def initialize(width:, height:)
    @width  = width
    @height = height
    @state  = ' ' * (width * height)
  end

  def iterate
  end
end
