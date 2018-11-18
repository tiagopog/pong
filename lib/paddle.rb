# Deals with the logic of the pong's paddle.
# @author Tiago Guedes <tiagopog@gmail.com>
class Paddle < Rectangle
  DEFAULTS = { speed: 3 }.freeze

  attr_accessor :speed, :constraints

  # @api public
  # @param speed [Integer, Float, nil] pad's current speed
  # @param constraints [Hash] pad's constraints (e.g. max "y")
  # @return [Pad]
  def initialize(speed: nil, constraints: {}, **args)
    super(args)
    @speed = speed || DEFAULTS[:speed]
    @constraints = constraints
  end

  # @api public
  # @param event [Ruby2D::Window::KeyEvent] event captured from keyboard
  # @param speed [Integer, Float, nil] pad's speed
  # @return [Integer, Float] pad's current y position
  def move(event, up:, down:)
    if move_up?(event, up)
      self.y -= speed
    elsif move_down?(event, down)
      self.y += speed
    end
  end

  private

  # @api private
  # @param event [Ruby2D::Window::KeyEvent] event captured from keyboard
  # @param up [String] expected keyboard key for the up movement
  # @return [Boolean] is it allowed to move up?
  def move_up?(event, up)
    min_y = constraints.dig(:y, :min)
    event.key == up && (!min_y || y - speed >= min_y)
  end

  # @api private
  # @param event [Ruby2D::Window::KeyEvent] event captured from keyboard
  # @param down [String] expected keyboard key for the down movement
  # @return [Boolean] is it allowed to move down?
  def move_down?(event, down)
    max_y = constraints.dig(:y, :max)
    event.key == down && (!max_y || y + speed + height <= max_y)
  end
end
