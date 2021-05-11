local M = {}

M.POSITION = vmath.vector3(10, 20, 0)
M.FORMAT = "MEM %dkb"
M.COLOR = vmath.vector4(0, 0, 1, 1)

function M.create(format, position, color)
	format = format or M.FORMAT
	position = position or M.POSITION
	color = color or M.COLOR

	local instance = {}

	local mem = collectgarbage("count")

	local message = { text = format:format(mem), position = position, color = color }
	
	function instance.update()
		mem = collectgarbage("count")
	end

	function instance.mem()
		return mem
	end

	function instance.draw()
		message.text = format:format(mem)
		msg.post("@render:", "draw_debug_text", message)
	end
	
	return instance
end

local singleton = M.create()

function M.update()
	singleton.update()
end

function M.mem()
	return singleton.mem()
end

function M.draw()
	singleton.draw()
end

return M