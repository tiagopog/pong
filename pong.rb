require 'ruby2d'

require './lib/ball'
require './lib/pad'

set title: 'Pong',
    background: 'black',
    with: 640,
    height: 480,
    resizable: false

ball = Ball.new(
  x: 50,
  y: 50,
  size: 20,
  speed: 3
)

pad1 = Pad.new(
  x: 2,
  y: get(:height) / 2 - 80 / 2,
  height: 80,
  width: 20,
  speed: 3,
  constraints: { y: { min: 0, max: 480 } }
)

pad2 = Pad.new(
  x: 640 - (2 + 20),
  y: get(:height) / 2 - 80 / 2,
  height: 80,
  width: 20,
  speed: 3,
  constraints: { y: { min: 0, max: 480 } }
)

score = { left: 0, right: 0 }

on :key_held do |event|
  pad1.move(event, up: 'w', down: 's')
  pad2.move(event, up: 'o', down: 'k')
end

update do
  ball.move(window: get(:window), pads: { left: pad1, right: pad2 })

  if ball.scored?
    player = ball.scored_at == :left ? :right : :left
    score[player] += 1
  end

  puts "A: #{score[:left]}; B: #{score[:right]}"
end

show
