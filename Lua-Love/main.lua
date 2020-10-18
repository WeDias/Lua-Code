function love.load()
  -- Configurações do jogo --
  love.keyboard.setKeyRepeat(true)
  love.graphics.setNewFont(20)
  fundo = love.graphics.newImage('img/fundo.png')
  
  -- Configurações do avião --
  aviao = {}
  aviao.x = 150
  aviao.y = 300
  aviao.tempoVoo = 0
  aviao.velocidade = 10
  aviao.combustivel = 10
  aviao.gastoCombus = 0.01
  aviao.imgD = love.graphics.newImage('img/aviaoD.png')
  aviao.imgE = love.graphics.newImage('img/aviaoE.png')
  aviao.imgA = aviao.imgD
  
  function aviao.criar()
    love.graphics.draw(aviao.imgA, aviao.x, aviao.y)
  end
  
  function aviao.status()
    status = string.format(
      'COMBUSTÍVEL: %0.2f\tTEMPO: %ds',
      aviao.combustivel,
      aviao.tempoVoo
    )
    love.graphics.print(status, 5, 575)
  end
  
  function aviao.contador(dt)
    if aviao.combustivel >= aviao.gastoCombus - 0.001 then
      aviao.tempoVoo = aviao.tempoVoo + dt
    end
  end
  
  function aviao.abastecer(qtd)
    aviao.combustivel = aviao.combustivel + qtd
  end
  
  function aviao.queimarCombustivel()
    if aviao.combustivel >= aviao.gastoCombus - 0.001 then
      aviao.combustivel = aviao.combustivel - aviao.gastoCombus
    else
      aviao.combustivel = 0
    end
  end
  
  function aviao.controle(key)
    local teclas = {
      ['up'] = function() 
                  aviao.y = aviao.y - aviao.velocidade
               end,
      ['down'] = function() 
                  aviao.y = aviao.y + aviao.velocidade 
                 end,
      ['left'] = function() 
                  aviao.imgA = aviao.imgE
                  aviao.x = aviao.x - aviao.velocidade
                 end,
      ['right'] = function() 
                    aviao.imgA = aviao.imgD
                    aviao.x = aviao.x + aviao.velocidade 
                  end
    }
    if type(teclas[key]) == 'function' then
      if aviao.combustivel >= aviao.gastoCombus - 0.001 then
        teclas[key]()
        aviao.queimarCombustivel()
      end
    end
  end
end


function love.keypressed(keyP)
    aviao.controle(keyP)
end


function love.update(dt)
  aviao.contador(dt)
end


function love.draw()
  love.graphics.draw(fundo)
  aviao.criar()
  aviao.status()
  if aviao.combustivel < aviao.gastoCombus - 0.001 then
    love.graphics.print('FIM DE JOGO!!', 350, 300)
  end
end
