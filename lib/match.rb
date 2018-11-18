# Deals with the logic of the pong's match.
# @author Tiago Guedes <tiagopog@gmail.com>
class Match
  attr_accessor :paused, :score, :reseted_at

  # @api public
  # @return [Match]
  def initialize
    @score  = { left: 0, right: 0 }
    @paused = true
  end

  # @api public
  # @return [Boolaen]
  alias paused? paused

  # @api public
  # @return [Boolaen]
  def wait_to_start?
    !reseted_at.nil?
  end

  # @api public
  # @return [nil]
  def check_wait!(current_frame)
    self.reseted_at = nil if current_frame - reseted_at >= 60
  end

  # @api public
  # @param ball [Ball] the game's ball
  # @param display [Hash] Hash of Text objects for the game's score display
  # @return [Integer]
  def update_score!(ball, display)
    side = ball.scored_at == :left ? :right : :left
    self.score[side] += 1
    display[side].text = score[side]
  end

  # @api public
  # @param window [Window] the game's window
  # @param ball [Ball] the game's ball
  # @return [Ingeter]
  def restart!(window, ball)
    ball.scored_at = nil
    ball.reset_position!(window)
    self.reseted_at = window.get(:frames)
  end
end
