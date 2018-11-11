require 'ruby2d'

require './lib/ball'
require './lib/pad'

##
# Window & FPS
##

set title: 'Pong',
    background: 'black',
    with: 640,
    height: 480,
    resizable: false

fps_display = Text.new(get(:fps).to_i, x: 315, y: 463, size: 12)

##
# Ball
##

ball = Ball.new(
  x: 50,
  y: 50,
  size: 20,
  speed: 4
)

##
# Pads
##

pad1 = Pad.new(
  x: 2,
  y: get(:height) / 2 - 80 / 2,
  height: 80,
  width: 20,
  speed: 4,
  constraints: { y: { min: 0, max: 480 } }
)

pad2 = Pad.new(
  x: 640 - (2 + 20),
  y: get(:height) / 2 - 80 / 2,
  height: 80,
  width: 20,
  speed: 4,
  constraints: { y: { min: 0, max: 480 } }
)

##
# Score
##

score = { left: 0, right: 0 }
score_display = {
  left: Text.new(score[:left], x: 300),
  right: Text.new(score[:right], x: 340)
}

##
# Game loop & Events
##

on :key_held do |event|
  pad1.move(event, up: 'w', down: 's')
  pad2.move(event, up: 'o', down: 'k')
end

update do
  ball.move(window: get(:window), pads: { left: pad1, right: pad2 })

  if ball.scored?
    player = ball.scored_at == :left ? :right : :left
    score[player] += 1
    score_display[player].text = score[player]
  end

  fps_display.text = get(:fps).to_i
end

show
