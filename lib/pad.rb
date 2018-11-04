# Deals with the pong's pad logic.
# @author Tiago Guedes <tiagopog@gmail.com>
class Pad < Rectangle
  DEFAULTS = { speed: 3 }.freeze

  attr_accessor :speed

  # @api public
  # @param speed [Integer, Float, nil] pad's speed
  # @return [Pad]
  def initialize(speed: nil, **args)
    super(args)
    @speed = speed || DEFAULTS[:speed]
  end

  # @api public
  # @param speed [Integer, Float, nil] pad's speed
  # @return [Integer, Float] pad's current y position
  def move(event, up:, down:)
    case event.key
    when up   then self.y -= speed
    when down then self.y += speed
    end
  end
end
