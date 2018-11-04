require 'ruby2d'

set title: 'Pong',
    background: 'black',
    with: 640,
    height: 480,
    resizable: false


ball = Square.new(x: 50, y: 50, size: 20)
direction = { x: 1, y: 1 }
speed = 3

tick = 0

update do
  if ball.x + ball.width >= get(:width) || ball.x <= 0
    direction[:x] *= -1
  end

  if ball.y + ball.height >= get(:height) || ball.y <= 0
    direction[:y] *= -1
  end

  ball.y += direction[:y] * speed
  ball.x += direction[:x] * speed

  tick += 1
end

show
