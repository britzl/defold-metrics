local M = {}

M.POSITION = vmath.vector3(10, 20, 0)
M.FORMAT = "MEM %dkb"
M.COLOR = vmath.vector4(0, 0, 1, 1)
M.AVARAGE = " - AVG %dkb"
M.AVARAGE_INTERVAL = 120 -- 2s

function M.create(format, position, color, show_avarage, avarage_interval)
	format = format or M.FORMAT
	position = position or M.POSITION
	color = color or M.COLOR
	avarage_interval = avarage_interval or M.AVARAGE_INTERVAL

	local instance = {}

	local mem = collectgarbage("count")

	local frame = 0
	local avarage_mem = 0
	local avarage_interval = 120 -- messure an avarage of 2s worth of memory usage
	local avarage_mem_sum = 0
	
	local message = { text = format:format(mem), position = position, color = color }
	
	function instance.update()
	
		mem = collectgarbage("count")

		-- Caclulate an avarage memory usage during a 120 frame period
		frame = frame + 1
		if (frame % avarage_interval == 0) then
			avarage_mem = avarage_mem_sum / avarage_interval
			avarage_mem_sum = 0
		else 
			avarage_mem_sum = avarage_mem_sum + mem
		end
	end

	function instance.mem()
		return mem
	end

	function instance.draw()
		if show_avarage then
			message.text = format:format(mem) .. M.AVARAGE:format(avarage_mem)
		else
			message.text = format:format(mem)
		end
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