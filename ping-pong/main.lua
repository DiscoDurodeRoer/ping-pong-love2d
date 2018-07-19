function love.load()

    love.window.setTitle("Pong")
    love.window.setMode(1600, 800)

    barritaJ1 = {}
    barritaJ1.x = 50
    barritaJ1.y = 300
    barritaJ1.ancho = 50
    barritaJ1.altura = 250
    barritaJ1.velocidad = 5

    barritaJ2 = {}
    barritaJ2.x = 1500
    barritaJ2.y = 300
    barritaJ2.ancho = 50
    barritaJ2.altura = 250
    barritaJ2.velocidad = 5

end

function love.update(dt)

  moverBarrita(barritaJ1, "w", "s")
  moverBarrita(barritaJ2, "up", "down")

end

function love.draw()

  love.graphics.rectangle("fill", barritaJ1.x, barritaJ1.y, barritaJ1.ancho, barritaJ1.altura)
  love.graphics.rectangle("fill", barritaJ2.x, barritaJ2.y, barritaJ2.ancho, barritaJ2.altura)


  love.graphics.rectangle("fill", (love.graphics.getWidth() / 2), 25, 25, 150)
  love.graphics.rectangle("fill", (love.graphics.getWidth() / 2), 225, 25, 150)
  love.graphics.rectangle("fill", (love.graphics.getWidth() / 2), 425, 25, 150)
  love.graphics.rectangle("fill", (love.graphics.getWidth() / 2), 625, 25, 150)

end

function moverBarrita(barrita, movArriba, movAbajo)

  if love.keyboard.isDown(movArriba) and barrita.y >= 0 then
    barrita.y = barrita.y - barrita.velocidad
  end

  if love.keyboard.isDown(movAbajo) and (barrita.y + barrita.altura) <= love.graphics.getHeight()  then
    barrita.y = barrita.y + barrita.velocidad
  end


end
