function love.load()
  tie = love.graphics.newImage("tie.png")
  tausta = love.graphics.newCanvas(840,650*2)
  love.graphics.setCanvas(tausta)
  love.graphics.draw(tie,0,0)
  love.graphics.draw(tie,0,650)
  love.graphics.setCanvas()
  rullaus =-650
  nopeus = 100--pikseliä sekunnissa
  
  auto = love.graphics.newImage("auto.png")
  autox = 240
  suunta="eteen"
  
  samisarvinen = love.graphics.newImage("samisarvinen.png")
  rullaus2=0
  samisarvinenX=math.random()
  
  prum = love.audio.newSource("prum.wav","static")
  prum:setLooping(true)
  prum:play()
end

function love.keypressed(key)
  if key == ("left" or key == "a") and suunta == "eteen" then suunta = "vasen" end
  if key == ("right" or key == "d") and suunta == "eteen" then suunta = "oikea" end
  if key == ("left" or key == "a") and suunta == "oikea" then suunta = "eteen" end
  if key == ("right" or key == "d") and suunta == "vasen" then suunta = "eteen" end
end


function love.update(dt)
  rullaus=rullaus+dt*nopeus
  if rullaus>=0 then rullaus=-650 end
  
  rullaus2=rullaus2+dt*100
  if rullaus2>650 then rullaus2=-50
    samisarvinenX = math.random(1,600) end
  
  if suunta == "vasen" then autox=autox-dt*50 end
  if suunta == "oikea" then autox=autox+dt*50 end
  
end


function love.draw()
  love.graphics.draw(tausta,0,rullaus)
  love.graphics.draw(samisarvinen,samisarvinenX,rullaus2)
  love.graphics.draw(auto,autox,400,0,0.35,0.35)

end
