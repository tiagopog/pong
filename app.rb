require 'ruby2d'
require_relative './lib/ball'


set title: 'Pong',
    background: 'black',
    with: 640,
    height: 480,
    resizable: false

ball = Ball.new(x: 50, y: 50, size: 20, speed: 3)

tick = 0

update do
  ball.move(get(:window))
  tick += 1
end

show
