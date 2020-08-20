function love.load()
	joystick = require "joystick"
	joystick.new(400, 100, 80, 80/3, {r = 1, g = 0.3, b = 0.3, a = 1},  {r = 0.3, g = 0.3, b = 1, a = 0.7}) --creates a joystick on x = 400 and y = 100. Big circle radius is 80, small radius is 1/3 of big radius. Sets the circle color to red and inner circle color to blue with little transparency.
	joystick.new(30, 100)-- creates a default joystick on coordinates 30, 100
end

function love.draw()
	--joystick.get(ID) gets a joystick data with given ID. First joystick created ever will have ID 1 etc. Joysticks info includes
	--x - x coordinate, y - y coordinate, innerX - inner circle x, innerY - inner circle y, radius - joystick radius, innerRadius - smaller circle radius, color - bigger circle color, innerColor - color of smaller circle, dx - joystick x state. A value between -1 (left side) through zero (middle) to 1 (right side), dy - joystick y state. Measured equivalent to x, from top to bottom.
	love.graphics.print(joystick.get(2).dx .. "    " .. joystick.get(2).dy, 10, 50)
	love.graphics.print(joystick.get(1).dx .. "    " .. joystick.get(1).dy, 280, 50)
	joystick.draw()
end

function love.touchpressed(id, x, y)
	joystick.checkTouch(id, x, y)
end

function love.touchmoved(id, x, y, dx, dy)
	joystick.touchmoved(id, x, y, dx, dy)
end

function love.touchreleased(id)
	joystick.touchreleased(id)
end