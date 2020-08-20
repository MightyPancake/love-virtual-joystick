joystick = {}

joysticks = {}

function joystick.new(x,y,radius, innerRadius, color, innerColor)
	local x = x or 0
	local y = y or 0
	local radius = radius or 85
	local innerRadius = innerRadius or radius/3
	local color = color or {r = 1, g = 1, b = 1, a = 1}
	local innerColor = innerColor or color
	joysticks[#joysticks + 1] = {x = x, y = y, radius = radius, innerRadius = innerRadius, color = color, innerColor = innerColor, innerX = x + radius - innerRadius, innerY = y + radius - innerRadius}
end

function joystick.touchmoved(id, x, y, dx, dy)
	if joysticks[1] then
		for i = 1, #joysticks do
			local joy = joysticks[i]
			if joy.touch == id then
			local targetX = x - joy.innerRadius
			local targetY = y - joy.innerRadius
				if x > joy.x + 2*joy.radius then
					targetX = joy.x + 2*joy.radius - joy.innerRadius
				end
				if x < joy.x then
					targetX = joy.x - joy.innerRadius
				end
				if y > joy.y + 2*joy.radius then
					targetY = joy.y + 2*joy.radius - joy.innerRadius
				end
				if y < joy.y then
					targetY = joy.y - joy.innerRadius
				end
				joy.innerX = targetX
				joy.innerY = targetY
			end
		end
	end
end

function joystick.checkTouch(id, x, y)
	if joysticks[1] then
		for i = 1, #joysticks do
			local joy = joysticks[i]
			if x > joy.x and y > joy.y and x < joy.x + 2*joy.radius and y < joy.y + 2*joy.radius then
				joysticks[i].touch = id
				joysticks[i].innerX = x - joy.innerRadius
				joysticks[i].innerY = y - joy.innerRadius
			end
		end
	end
end

function joystick.touchreleased(id)
	if joysticks[1] then
		for i = 1, #joysticks do
			local joy = joysticks[i]
			if joy.touch == id then
				joystick.deleteTouch(joy)
			end
		end
	end
end

function joystick.draw()
	if joysticks[1] then
	r,g,b,a = love.graphics.getColor()
		for i = 1, #joysticks do
			local joy = joysticks[i]
			love.graphics.setColor(joy.color.r, joy.color.g, joy.color.b, joy.color.a)
			love.graphics.circle("line", joy.x + joy.radius, joy.y + joy.radius, joy.radius)
			local color = joy.innerColor
			love.graphics.setColor(color.r, color.g, color.b, color.a)
			love.graphics.circle("fill", joy.innerX + joy.innerRadius, joy.innerY + joy.innerRadius, joy.innerRadius)
		end
		love.graphics.setColor(r,g,b,a)
	end
end

function joystick.deleteTouch(joy)
	joy.touch = nil
	joy.innerX = joy.x + joy.radius - joy.innerRadius
	joy.innerY = joy.y + joy.radius - joy.innerRadius
end

function joystick.get(ID)
	local joy = joysticks[ID]
	joy.dx = (joy.x +joy.radius - (joy.innerX + joy.innerRadius))/-joy.radius
	joy.dy = (joy.y +joy.radius - (joy.innerY + joy.innerRadius))/-joy.radius
	return joy
end

return joystick