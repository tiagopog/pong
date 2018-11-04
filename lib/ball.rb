class Ball < Square
  DEFAULTS = {
    speed: 3,
    direction: { x: 1, y: 1 }
  }.freeze

  attr_accessor :speed, :direction

  # @api public
  # @param speed [Integer, Float, nil] ball's speed
  # @param direction [Hash, nil] ball's x and y directions
  # @return [Ball]
  def initialize(speed: nil, direction: nil, **args)
    super(args)
    @speed = speed || DEFAULTS[:speed]
    @direction = direction || DEFAULTS[:direction]
  end

  # @api public
  # @param window [Window] the game window
  # @return [Hash] ball's current position
  def move(window)
    if x + width >= window.get(:width) || x <= 0
      self.direction[:x] *= -1
    end

    if y + height >= window.get(:height) || y <= 0
      self.direction[:y] *= -1
    end

    self.x += direction[:x] * speed
    self.y += direction[:y] * speed

    { x: x, y: y }
  end
end
