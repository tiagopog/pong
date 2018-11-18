# Deals with the logic of the pong's ball.
# @author Tiago Guedes <tiagopog@gmail.com>
class Ball < Square
  DEFAULTS = {
    speed: 3,
    direction: { x: 1, y: 1 }
  }.freeze

  attr_accessor :speed, :direction, :scored_at

  # @api public
  # @param speed [Integer, Float, nil] ball's speed
  # @param direction [Hash, nil] ball's x and y axis directions
  # @return [Ball]
  def initialize(speed: nil, direction: nil, **args)
    super(args)
    @speed = speed || DEFAULTS[:speed]
    @direction = direction || DEFAULTS[:direction]
  end

  # @api public
  # @param window [Window] the game's window
  # @param pads [Hash] the game's pads
  # @return [Hash] ball's current position
  def move(window:, pads:)
    self.scored_at = nil

    if edge_collision?(:x, window)
      self.scored_at = check_edge_collision(:x, window)
      self.direction[:x] *= -1
    elsif edge_collision?(:y, window)
      self.direction[:y] *= -1
    elsif pad_collision?(pads)
      self.direction[:x] *= -1
    end

    self.x += direction[:x] * speed
    self.y += direction[:y] * speed

    { x: x, y: y }
  end

  # @api public
  # @return [Boolean] did it score a new point?
  def scored?
    !scored_at.nil?
  end

  # @api public
  # @param window [Window] the game's window
  # @return [Integer, Float]
  def reset_position!(window)
    self.x = window.get(:width) / 2 - width / 2
    self.y = rand(height..window.get(:height) - height)
  end

  private

  # @api private
  # @param axis [Symbol] which axis to check the collision
  # @param window [Window] the game's window
  # @return [Boolean]
  def edge_collision?(axis, window)
    !check_edge_collision(axis, window).nil?
  end

  # @api private
  # @param axis [Symbol] which axis to check the collision
  # @param window [Window] the game's window
  # @return [Symbol] edge side where ball has collided
  def check_edge_collision(axis, window)
    if axis == :x && x + width >= window.get(:width)
      :right
    elsif axis == :x && x <= 0
      :left
    elsif axis == :y && y + height >= window.get(:height)
      :bottom
    elsif axis == :y && y <= 0
      :top
    end
  end

  # @api private
  # @param pads [Hash] the game's pads
  # @return [Boolean] has the ball collided with any of the pads?
  def pad_collision?(pads)
    pads.any? do |pad|
      y <= pad.y + pad.height && y + height >= pad.y &&
        [x + width, pad.x + pad.width].min - [x, pad.x].max > 0
    end
  end
end
