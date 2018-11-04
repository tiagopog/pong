class Ball < Square
  attr_accessor :speed, :direction

  # @api public
  # @param speed [Integer] the ball speed
  def initialize(speed:, **args)
    super(args)
    @speed = speed || 3
    @direction = { x: 1, y: 1 }
  end

  # @api public
  # @param window [Window] the game window
  def move(window)
    if x + width >= window.get(:width) || x <= 0
      self.direction[:x] *= -1
    end

    if y + height >= window.get(:height) || y <= 0
      self.direction[:y] *= -1
    end

    self.x += direction[:x] * speed
    self.y += direction[:y] * speed
  end
end
