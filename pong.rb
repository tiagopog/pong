require 'ruby2d'

require './lib/ball'
require './lib/paddle'
require './lib/match'

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

score_display = {
  left: Text.new(
    0,
    x: get(:width) / 2 - 100,
    y: 5,
    font: 'assets/PressStart2P.ttf',
    color: 'gray',
    size: 40
  ),
  right: Text.new(
    0,
    x: get(:width) / 2 + 60,
    y: 5,
    font: 'assets/PressStart2P.ttf',
    color: 'gray', size: 40
  )
}

##
# Pause
##

pause_display = Text.new(
  'PRESS SPACE',
  x: get(:width) / 2 - 110,
  y: get(:height) / 2 - 20,
  font: 'assets/PressStart2P.ttf',
  color: 'gray',
  size: 20,
  opacity: 1
)

##
# Main
##

match = Match.new

# Paddle movement
on :key_held do |event|
  pad1.move(event, up: 'w', down: 's')
  pad2.move(event, up: 'o', down: 'k')
end

# Game pause
on :key_down do |event|
  if event.key == 'space'
    match.paused = !match.paused
    pause_display.color.opacity *= -1
  end
end

update do
  fps_display.text = get(:fps).to_i

  if match.paused?
    next
  elsif match.wait_to_start?
    match.check_wait!(get(:frames))
  else
    ball.move(window: get(:window), pads: [pad1, pad2])

    if ball.scored?
      match.update_score!(ball, score_display)
      match.restart!(get(:window), ball)
    end
  end
end

show
