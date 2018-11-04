require 'ruby2d'

require_relative './lib/ball'
require_relative './lib/pad'

set title: 'Pong',
    background: 'black',
    with: 640,
    height: 480,
    resizable: false

ball = Ball.new(x: 50, y: 50, size: 20, speed: 3)
pad  = Pad.new(x: 2, y: get(:height) / 2 - 80 / 2, height: 80, width: 20, speed: 3)

tick = 0

on :key_held do |event|
  pad.move(event, up: 'w', down: 's')
end

update do
  ball.move(window: get(:window), pads: [pad])
  tick += 1
end

show
