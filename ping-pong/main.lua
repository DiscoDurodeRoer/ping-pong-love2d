function love.load()

    icono = love.graphics.newImage("icono.png")
    love.window.setIcon(icono:getData())


    love.window.setTitle("Pong")
    love.window.setFullscreen(true)
    puntuacionJ1 = 0
    puntuacionJ2 = 0

    reset("J1")

    fuente = love.graphics.newFont(70)

    fuentePausa = love.graphics.newFont(15)

    sonidoPong = love.audio.newSource("pong.wav")

    sonidoPunto = love.audio.newSource("grito.mp3")

    pausa = false


end

function love.update(dt)

  if not pausa then

    moverBarrita(barritaJ1, "w", "s")
    moverBarrita(barritaJ2, "up", "down")

    rebotarPelota(pelota)
  end

end

function love.draw()

  if pausa then
    love.graphics.setFont(fuentePausa)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Juego pausado, pulsa enter para regresar", 100, 100)

    love.graphics.setColor(105, 105, 105)
  end

  love.graphics.setFont(fuente)

  if not pausa then
    love.graphics.setColor(255, 255, 255)
  end

  love.graphics.print(puntuacionJ1, (love.graphics.getWidth() / 2)-200, 50 )
  love.graphics.print(puntuacionJ2, (love.graphics.getWidth() / 2)+200, 50 )

  love.graphics.rectangle("fill", barritaJ1.x, barritaJ1.y, barritaJ1.ancho, barritaJ1.altura)
  love.graphics.rectangle("fill", barritaJ2.x, barritaJ2.y, barritaJ2.ancho, barritaJ2.altura)

  for i=25,love.graphics.getHeight(), 200 do
    love.graphics.rectangle("fill", (love.graphics.getWidth() / 2), i, 25, 150)
  end
  if not pausa then
    love.graphics.setColor(255, 0, 0)
  end
  love.graphics.circle("fill", pelota.x, pelota.y, pelota.radio)

end

function love.keypressed(key, scancode, isrepeat)

  if key == "return" then
    pausa = not pausa
  end

  if key == "escape" then
    love.event.quit()
  end

end

function moverBarrita(barrita, movArriba, movAbajo)

  if love.keyboard.isDown(movArriba) and barrita.y >= 0 then
    barrita.y = barrita.y - barrita.velocidad
  end

  if love.keyboard.isDown(movAbajo) and (barrita.y + barrita.altura) <= love.graphics.getHeight()  then
    barrita.y = barrita.y + barrita.velocidad
  end

end

function rebotarPelota(pelota)

  if pelota.derecha then
    pelota.x = pelota.x + pelota.velocidad
  else
    pelota.x = pelota.x - pelota.velocidad
  end

  if pelota.arriba then
    pelota.y = pelota.y - pelota.velocidad
  else
    pelota.y = pelota.y + pelota.velocidad
  end

  if (pelota.x ) >= (barritaJ1.x )
      and (pelota.x) <= (barritaJ1.x + barritaJ1.ancho)
      and (pelota.y - pelota.radio) <= (barritaJ1.y + barritaJ1.altura)
      and (pelota.y - pelota.radio) >= (barritaJ1.y)   then
        love.audio.play(sonidoPong)
      pelota.arriba = false
  end

  if (pelota.x ) >= (barritaJ1.x )
      and (pelota.x) <= (barritaJ1.x + barritaJ1.ancho)
      and (pelota.y + pelota.radio) >= (barritaJ1.y)
      and (pelota.y + pelota.radio) <= (barritaJ1.y + barritaJ1.altura) then
      love.audio.play(sonidoPong)
      pelota.arriba = true
  end

  if (pelota.x ) >= (barritaJ2.x )
      and (pelota.x) <= (barritaJ2.x + barritaJ2.ancho)
      and (pelota.y - pelota.radio) <= (barritaJ2.y + barritaJ2.altura)
      and (pelota.y + pelota.radio) >= (barritaJ2.y)   then
        love.audio.play(sonidoPong)
      pelota.arriba = false
  end

  if (pelota.x ) >= (barritaJ2.x )
      and (pelota.x) <= (barritaJ2.x + barritaJ2.ancho)
      and (pelota.y + pelota.radio) >= (barritaJ2.y)
      and (pelota.y + pelota.radio) <= (barritaJ2.y + barritaJ2.altura) then
        love.audio.play(sonidoPong)
      pelota.arriba = true
  end

  if (pelota.x - pelota.radio) <= (barritaJ1.x + barritaJ1.ancho)
      and (pelota.x - pelota.radio) >= (barritaJ1.x)
      and (pelota.y ) >= (barritaJ1.y)
      and (pelota.y ) <= (barritaJ1.y + barritaJ1.altura) then
        love.audio.play(sonidoPong)
      pelota.derecha = true
      pelota.velocidad = pelota.velocidad + 1
  end

  if (pelota.x + pelota.radio) >= (barritaJ2.x)
    and (pelota.x + pelota.radio) <= (barritaJ2.x + barritaJ2.ancho)
    and (pelota.y ) >= (barritaJ2.y)
    and (pelota.y ) <= (barritaJ2.y + barritaJ2.altura) then
      love.audio.play(sonidoPong)
    pelota.derecha = false
    pelota.velocidad = pelota.velocidad + 1
  end

  if (pelota.x + pelota.radio) >= love.graphics.getWidth() then
    reset("J1")
    love.audio.play(sonidoPunto)
    puntuacionJ1 = puntuacionJ1 + 1
  end

  if (pelota.x - pelota.radio) <= 0 then
    reset("J2")
    love.audio.play(sonidoPunto)
    puntuacionJ2 = puntuacionJ2 + 1
  end

  if (pelota.y + pelota.radio) >= love.graphics.getHeight() then
    pelota.arriba = true
  end

  if (pelota.y - pelota.radio) <= 0 then
    pelota.arriba = false
  end

end


function reset(jugador_punto)

  barritaJ1 = {}
  barritaJ1.x = 50
  barritaJ1.y =  love.graphics.getHeight() / 2
  barritaJ1.ancho = 50
  barritaJ1.altura = 250
  barritaJ1.velocidad = 5

  barritaJ2 = {}
  barritaJ2.x = love.graphics.getWidth() - 100
  barritaJ2.y = love.graphics.getHeight() / 2
  barritaJ2.ancho = 50
  barritaJ2.altura = 250
  barritaJ2.velocidad = 5

  pelota = {}
  pelota.x = love.graphics.getWidth() / 2
  pelota.y = love.graphics.getHeight() / 2
  pelota.radio = 20

  if jugador_punto == "J1" then
    pelota.derecha = false
  else
    pelota.derecha = true
  end

  pelota.arriba = false
  pelota.velocidad = 5

end
