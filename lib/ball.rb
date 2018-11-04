# Deals with the pong's ball logic.
# @author Tiago Guedes <tiagopog@gmail.com>
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
  # @param pads [Array<Pad>] the game pads
  # @return [Hash] ball's current position
  def move(window:, pads:)
    if x + width >= window.get(:width) || x <= 0 || pad_collision?(pads)
      self.direction[:x] *= -1
    end

    if y + height >= window.get(:height) || y <= 0
      self.direction[:y] *= -1
    end

    self.x += direction[:x] * speed
    self.y += direction[:y] * speed

    { x: x, y: y }
  end

  private

  # @api private
  # @param pads [Array<Pad>] the game pads
  # @return [Boolean] has the ball collided with any of the pads?
  def pad_collision?(pads)
    pads.any? do |pad|
      y >= pad.y && y <= pad.y + pad.height && x <= pad.x + pad.width
    end
  end
end
