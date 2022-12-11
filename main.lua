function love.load()
  --assetit
  tie = love.graphics.newImage("tie.png")
  tausta = love.graphics.newCanvas(840,650*2)
  love.graphics.setCanvas(tausta)
  love.graphics.draw(tie,0,0)
  love.graphics.draw(tie,0,650)
  love.graphics.setCanvas()
  rullaus =-650
  nopeus = 100--pikseliä sekunnissa
  
  auto = love.graphics.newImage("auto.png")
  autoX,autoY = 240,400
  suunta="eteen"
  
  samisarvinen = love.graphics.newImage("samisarvinen.png")
  samisarvinenY, samisarvinenX = 0, 240
  
  prum = love.audio.newSource("prum.wav","static")
  prum:setLooping(true)
  prum:play()
  
  au = love.audio.newSource("au.mp3","static")
  
  pistelaskuri=0
  piste2=false
end

function love.keypressed(key)
  if (key == "left" or key == "a") and suunta == "eteen" then suunta = "vasen" end
  if (key == "right" or key == "d") and suunta == "eteen" then suunta = "oikea" end
  if (key == "left" or key == "a") and suunta == "oikea" then suunta = "eteen" end
  if (key == "right" or key == "d") and suunta == "vasen" then suunta = "eteen" end
end

function törmäys(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

function love.update(dt)
  rullaus=rullaus+dt*nopeus
  if rullaus>=0 then rullaus=-650 end
  
  samisarvinenY=samisarvinenY+dt*nopeus
  if samisarvinenY>650 then samisarvinenY=-50
    samisarvinenX = math.random(1,800) end
  
  if suunta == "vasen" and autoX>130 then autoX=autoX-dt*50*(nopeus/100) end
  if suunta == "oikea" and autoX<620 then autoX=autoX+dt*50*(nopeus/100) end
  if suunta == "vasen" and math.floor(autoX)==130 then suunta="eteen" end
  if suunta == "oikea" and math.ceil(autoX)==620 then suunta="eteen" end
  
  nopeus=nopeus+dt
  
  piste=törmäys(samisarvinenX+20,samisarvinenY+20,60,60,autoX,autoY,92,180)
  if (not piste==piste2) and piste==true then
    piste2=true
    pistelaskuri=pistelaskuri+1
    love.audio.play(au)
  end
  
  if (not piste==piste2) and piste==false then
    piste2=false
  end
  
end


function love.draw()
  --tie, sami, auto
  love.graphics.draw(tausta,0,rullaus)
  love.graphics.draw(samisarvinen,samisarvinenX,samisarvinenY)
  love.graphics.draw(auto,math.ceil(autoX),autoY,0,0.35,0.35)
  
  --hitboxit
  --[[love.graphics.rectangle("line",samisarvinenX+20,samisarvinenY+20,60,60)
  love.graphics.rectangle("line",autoX,autoY,92,180)--]]
  
  --pisteet
  love.graphics.print(pistelaskuri,60,30)
end
