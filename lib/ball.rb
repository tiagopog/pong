# Deals with the pong's ball logic.
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
  # @param window [Window] the game window
  # @param pads [Hash] the game pads
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

  private

  # @api private
  # @param axis [Symbol] which axis to check the collision
  # @param window [Window] the game window
  # @return [Boolean]
  def edge_collision?(axis, window)
    !check_edge_collision(axis, window).nil?
  end

  # @api private
  # @param axis [Symbol] which axis to check the collision
  # @param window [Window] the game window
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
  # @param pads [Hash] the game pads
  # @return [Boolean] has the ball collided with any of the pads?
  def pad_collision?(pads)
    pads.any? do |position, pad|
      y >= pad.y && y <= pad.y + pad.height && (
        position == :left && x <= pad.x + pad.width ||
        position == :right && x + width >= pad.x
      )
    end
  end
end
