local M = {}

M.POSITION = vmath.vector3(10, 20, 0)
M.FORMAT = "FPS %.2f"
M.COLOR = vmath.vector4(0, 0, 1, 1)

function M.create(samples)
	samples = samples or 60
	
	local instance = {}

	local frames = {}

	local fps = 0

	function instance.update()
		table.insert(frames, socket.gettime())
		if #frames == samples + 1 then
			table.remove(frames, 1)
			fps = 1 / ((frames[#frames] - frames[1]) / (#frames - 1))
		end
	end

	function instance.fps()
		return fps
	end

	function instance.draw(format, position, color)
		format = format or M.FORMAT
		position = position or M.POSITION
		color = color or M.COLOR
		msg.post("@render:", "draw_debug_text", { text = format:format(fps), position = position, color = color } )
	end

	return instance
end


local singleton = M.create()


function M.update()
	singleton.update()
end


function M.fps()
	return singleton.fps()
end


function M.draw(format, position, color)
	singleton.draw(format, position, color)
end



return M