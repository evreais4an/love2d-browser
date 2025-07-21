local threads = {}
local results = {}
local ipRange = 150

local port = 1487
local foundServer = nil
function distance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end
function dii(url)
    local response = {}
    local res, status = http.request{
        url = url,
        sink = function(chunk)
            table.insert(response, chunk)
            return #chunk
        end
    }
    return res, status, table.concat(response)
end
function mousem(x, y, dx, dy,id)
    
    dxx = dx
    dyy = dy
	id = id or 0
    
    if scene == "game" then
        if ism(50, windowHeight - 233*(windowHeight/400),233*(windowHeight/400),233*(windowHeight/400),x,y) or (id==MID and oss=="Android") then
            MOVE_D = 1
			MID = id
			xxx = x
			yyy = y
        else
		if ism(windowWidth-233*(windowHeight/400)-50, windowHeight - 233*(windowHeight/400),233*(windowHeight/400),233*(windowHeight/400),x,y) or (id==AID and oss=="Android") then
            ARROW_D = 1
			AID = id
			axx = x
			ayy = y
        end
		end
    end
end
love.window.setMode(1280, 720, {fullscreen = false, resizable = true})
width = love.graphics.getWidth()
height = love.graphics.getHeight()
function ism(x,y,w,h)
if love.mouse.getX()>x and love.mouse.getX()<x+w then
if love.mouse.getY()>y and love.mouse.getY()<y+h then
return true
end
else
return false
end
end
function fill(r,g,b)
love.graphics.setColor(love.math.colorFromBytes(r, g, b))
end
function love.touchmoved(id, x, y, dx, dy)
    if love.system.getOS() == "Android" then
        mousem(x, y, dx, dy,id)
    end
end

-- Обработчик движения мыши (для Windows)
function love.mousemoved(x, y, dx, dy, istouch)
    if love.mouse.isDown(1) and love.system.getOS() == "Windows" then
        mousem(x, y, dx, dy)
    end
end
function check_ip(i)
    local http = require("socket.http")
    local url = "http://192.168.1." .. tostring(i) .. ":" .. tostring(port)
    local _, status = http.request(url)
    if status == 200 then
        return url
    end
    return nil
end
function hb(hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end
iad = 0
fn = [[p/Erroro en konekto kun retejo]]
link = ""
result = nil
dai = 0
function love.load()
    font = love.graphics.newFont(16)

    -- Инициализация каналов для передачи данных между потоками и основным потоком
    local resultChannel = love.thread.getChannel("result")
    local fnChannel = love.thread.getChannel("fn")
    local linkChannel = love.thread.getChannel("link")

    -- Массив для хранения потоков
    threads = {}

    -- Запуск потоков для каждого IP
    for j = 0, 1 do  -- Часть адреса 192.168.j.i
        for i = 0, ipRange - 1 do  -- Для каждой возможной IP
            local thread = love.thread.newThread([[
                local i, j, port = ...
                local http = require("socket.http")
                local url = "http://192.168." .. tostring(j) .. "." .. tostring(i) .. ":" .. tostring(port)
                local c, status = http.request(url)

                if status == 200 then
                    -- Отправляем результат в основной поток
                    love.thread.getChannel("result"):push(url)
                    love.thread.getChannel("fn"):push(c)
                    love.thread.getChannel("link"):push(url)
                end
            ]])

            -- Запуск потока с передачей значений i, j, порта
            thread:start(i, j, port)

            -- Добавляем поток в массив для дальнейшего контроля
            table.insert(threads, thread)
        end
    end
end

ppd = 0
function getTextHeight(text, font, limit)
    local _, wrappedLines = font:getWrap(text, limit) -- Второй аргумент содержит строки
    local lineHeight = font:getHeight() -- Высота одной строки
    return #wrappedLines * lineHeight -- Число строк * высота одной строки
end

function love.update(dt)
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()
    local resultChannel = love.thread.getChannel("result")
    local url = resultChannel:pop()
    if url then
        foundServer = url
    end

    -- Обрабатываем ссылку
    local linkChannel = love.thread.getChannel("link")
    local newLink = linkChannel:pop()
    if newLink then
        link = newLink  -- Обновляем ссылку
    end

    -- Обрабатываем функцию (данные)
    local fnChannel = love.thread.getChannel("fn")
    local fnResult = fnChannel:pop()
    if fnResult then
        fn = fnResult  -- Сохраняем строку c в переменной fn
    end
	if ppd==0 and foundServer then
		ppd = 1
	end
end
loadd = 0
erload = [[w/120
img2/warn
h1/Erroro dum shargho la retejo
p/bonvolu provu la:
lc/Reshargho la retejo.
br/255
bg/255
bb/255
lc/Kontrolu interretta konekto kun la servilo.
blue/
w/16
link/index.html
p/NNeto]]
esperanto = love.graphics.newImage("img/esperanto.png")
warnn = love.graphics.newImage("img/warn.png")
bgr = 250
bgg = 250
bgb = 250
w = 15
f15 = love.graphics.newFont("roboto.ttf", 15)
f20 = love.graphics.newFont("roboto.ttf", 20)
f30 = love.graphics.newFont("roboto.ttf", 30)
f25 = love.graphics.newFont("roboto.ttf", 25)
f35 = love.graphics.newFont("roboto.ttf", 35)
f40 = love.graphics.newFont("roboto.ttf", 40)
f50 = love.graphics.newFont("roboto.ttf", 50)
font = love.graphics.newFont("roboto.ttf", 20)
ddy = 0
function love.draw()
    --[[love.graphics.push()
    love.graphics.translate(width / 2, height / 2) -- Сместить точку начала координат в центр
    love.graphics.rotate(math.rad(-90)) -- Повернуть всё на 90 градусов
    love.graphics.translate(-height / 2, -width / 2) -- Вернуть в начало]]
    love.graphics.setFont(f15)
    if foundServer then
		
		fill(230, 225, 225)
    love.graphics.rectangle("fill", 0, 0, width, width)
	
		fill(bgr,bgg,bgb)
		love.graphics.rectangle("fill", 0, 0, width*3, width*3)
		
		fill(0,0,0)
		
        y = 60+ddy
        for line in fn:gmatch("[^\r\n]+") do
            -- Проверка условий с изменением цвета и шрифта
			
			if string.sub(line,1,7)=="script/" then
				sc = 1
			elseif string.sub(line,1,3)=="br/" then
				t = tonumber(string.sub(line,4,#line))
				if t then
					bgr = t
				end
			elseif string.sub(line,1,3)=="bg/" then
				t = tonumber(string.sub(line,4,#line))
				if t then
					bgg = t
				end
			elseif string.sub(line,1,3)=="bb/" then
				t = tonumber(string.sub(line,4,#line))
				if t then
					bgb = t
				end
			elseif string.sub(line, 1, 4) == "red/" then
                fill(255, 0, 0)
            elseif string.sub(line, 1, 5) == "blue/" then
                fill(0, 0, 255)
            elseif string.sub(line, 1, 6) == "green/" then
                fill(0, 255, 0)
			elseif string.sub(line, 1, 6) == "white/" then
                fill(255, 255, 255)
			elseif string.sub(line, 1, 6) == "black/" then
                fill(0, 0, 0)
			
            elseif string.sub(line, 1, 2) == "p/" then
                love.graphics.setFont(f15)
                love.graphics.printf(string.sub(line, 3), 5, y,width-120)
                y = y + getTextHeight(string.sub(line, 3),f15,width-120)+2
            elseif string.sub(line, 1, 2) == "h/" then
                love.graphics.setFont(f40)
                love.graphics.printf(string.sub(line, 3), 5, y,width-120)
                y = y + getTextHeight(string.sub(line, 3),f40,width-120)+2
            elseif string.sub(line, 1, 3) == "h1/" then
                love.graphics.setFont(f35)
                love.graphics.printf(string.sub(line, 4), 5, y,width-120)
                y = y + getTextHeight(string.sub(line, 3),f35,width-120)+2
            elseif string.sub(line, 1, 3) == "h2/" then
                love.graphics.setFont(f30)
                love.graphics.printf(string.sub(line, 4), 5, y,width-120)
                y = y + getTextHeight(string.sub(line, 3),f30,width-120)+2
            elseif string.sub(line, 1, 3) == "h3/" then
                love.graphics.setFont(f25)
                love.graphics.printf(string.sub(line, 4), 5, y,width-120)
                y = y + getTextHeight(string.sub(line, 3),f25,width-120)+2
			elseif string.sub(line,1,5)=="img2/" then
				td = string.sub(line,6,#line)
				gg = warnn
				if td=="esperanto" then
					gg=esperanto
				end
				if td=="warn" then
					gg = warnn
				end
				local originalWidth = gg:getWidth()
				local originalHeight = gg:getHeight()
				scaleFactor = w / originalWidth -- Вычисляем коэффициент масштаба
				targetHeight = originalHeight * scaleFactor -- Подстраиваем высоту
				fill(255,255,255)
				love.graphics.draw(gg,5,y,0,scaleFactor,scaleFactor)
				y=y+gg:getHeight()*scaleFactor
				fill(0,0,0)
			elseif string.sub(line,1,2) == "b/" then
				love.graphics.rectangle("fill",0,y,width*3,w)
            elseif string.sub(line, 1, 3) == "h4/" then
                love.graphics.setFont(f20)
                love.graphics.printf(string.sub(line, 4), 25, y,width-120)
                y = y + getTextHeight(string.sub(line, 3),f20,width-120)+2
			elseif string.sub(line, 1, 3) == "lc/" then
				love.graphics.setFont(f15)
				love.graphics.ellipse("fill",10,y+8,5,5)
                love.graphics.printf(string.sub(line, 4), 25, y,width-120)
                y = y + getTextHeight(string.sub(line, 3),f15,width-120)+2
			elseif string.sub(line, 1, 3) == "lp/" then
				love.graphics.setFont(f15)
				love.graphics.rectangle("fill",10,y+8,5,5)
                love.graphics.print(string.sub(line, 4), 25, y)
                y = y + getTextHeight(string.sub(line, 3),f15,width-70)+2
			elseif line=="sep/" then
				love.graphics.rectangle("fill",0,y,height*3,1)
				y = y+4
			elseif string.sub(line,1,2) == "w/" then
				ys = tonumber(string.sub(line,3,5))
				w = ys
--					love.graphics.print("GOYDA", 25, y)
				
			elseif string.sub(line,1,5) == "link/" then
				love.graphics.rectangle("line",5,y,width-60,w)
				if ism(0,y,1000,w) and love.mouse.isDown(1) and loadd==0 then
					local http = require("socket.http")
					c, status = http.request(link .. "/" .. string.sub(line,6,#line))
					loadd = 0
					love.graphics.setFont(f40)
					love.graphics.print("Loading...",200,200)
					if status==200 then
						fn = c
						ddy = 0
						loadd = 0
					else
						fn = erload
						loadd = 0
					end
					--love.graphics.print(tostring(status) .. "  " .. result, 5, y)
				end
            else
				doadaw = 4
               
            end
        end
		fill(255,255,255)
		love.graphics.rectangle("fill",0,0,height*3,60)
		
        fill(5, 7, 10)
        love.graphics.setFont(font)
		
        love.graphics.print("Aktuala IP adreso : " .. foundServer, 10, 10)
		fill(170,170,170)
		love.graphics.rectangle("fill",width-50,60,50,height*3)
		fill(5,7,10)
		love.graphics.rectangle("line",width-50,60,50,50)
		love.graphics.rectangle("line",width-50,height-50,50,50)
		love.graphics.rectangle("line",width-50,110,50,50)
		love.graphics.print("Home",width-50,120)
		love.graphics.print("v",width-32,height-38)
		love.graphics.print("^",width-32,78)
		love.graphics.print(tostring(ddy),width-32,128)
		
		if love.mouse.isDown(1) then
		if ism(width-50,height-50,50,50) and ddy>-y+188 then
			ddy = ddy-2
		end
		if ism(width-50,60,50,50) and ddy<0 then
			ddy = ddy+2
		end
		if ism(width-50,110,50,50) then
			if love.mouse.isDown(1) then
					local http = require("socket.http")
					c, status = http.request(link .. "/index.html")
					
					if status==200 then
						fn = c
						ddy = 0
						loadd = 0
					else
						fn = erload
						loadd = 0
					end
					--love.graphics.print(tostring(status) .. "  " .. result, 5, y)
				end
		end
		
		if loadd==1 then
			
		end
	end
    else
		fill(255,255,255)
		love.graphics.rectangle("fill",0,0,height*6,width*3)
        fill(5, 7, 10)
        love.graphics.print("Servilo serĉo...", 10, 10)
		love.graphics.print(tostring(iad),10,30)
    end
   -- love.graphics.pop()
end
