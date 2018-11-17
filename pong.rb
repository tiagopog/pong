require 'ruby2d'

require './lib/ball'
require './lib/paddle'

##
# Window & FPS
##

set title: 'Pong',
    background: 'black',
    with: 640,
    height: 480,
    resizable: false

fps_display = Text.new(get(:fps).to_i, x: 315, y: 463, size: 12)

###
# Table
##

16.times do |i|
  Rectangle.new(
    width: 5,
    height: 15,
    x: get(:width) / 2 - 2.5,
    y: i * 30,
    color: 'gray'
  )
end

##
# Ball
##

ball = Ball.new(
  x: get(:width) / 2 - 5,
  y: get(:height) / 2 - 5 / 2,
  size: 10,
  speed: 5
)

##
# Paddles
##

pad1 = Paddle.new(
  x: 2,
  y: get(:height) / 2 - 60 / 2,
  width: 10,
  height: 60,
  speed: 7,
  constraints: { y: { min: 0, max: 480 } }
)

pad2 = Paddle.new(
  x: 640 - (2 + 10),
  y: get(:height) / 2 - 60 / 2,
  width: 10,
  height: 60,
  speed: 7,
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
  ball.move(window: get(:window), pads: [pad1, pad2])

  if ball.scored?
    player = ball.scored_at == :left ? :right : :left
    score[player] += 1
    score_display[player].text = score[player]
  end

  fps_display.text = get(:fps).to_i
end

show
