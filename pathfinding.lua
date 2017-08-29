-- will contain functions for
-- various forms of pathfinding,
-- such as distance-based (see
-- distance.lua), and A*

-- for now it's only breath-first path finding

-- Contributors: sulai

---
-- Breadth-first path finding.
-- Example usage
-- targets = find_path_breadth(startx, starty, 10,
-- 				function(cx,cy)
--                  -- make the path finder step on tiles with index>16 only
--					return mget(cx,cy)>16
--				end,
--				function(tx,ty)
--					-- accept tile index 20 as targets
--					return mget(tx,ty)==20
-- 				end)
-- -- now use the result of the path finding
-- for t in all(targets) do
-- 		mset(t.x, t.y, 0)
-- end
--
-- @param x coordinate to start path finding at
-- @param y coordinate to start path finding at
-- @param limit stop if this amount of targets were found
-- @param accept_child  callback method (x,y), return true if you accept this child
-- @param accept_target callback method (x,y), return true if you accept this as target
-- @return a table of coordinates matching what ever is defined in the callbacks.
-- The result might look something like this
-- {{x=...,y=...},...}
function find_path_breadth(x, y, limit, accept_child, accept_target)

	local targets = {} -- list od coordinates {x}{y} as result of this function
	local visited = {}
	for x=0,47 do
		visited[x] = {}
		for y=0,47 do
			visited[x][y]=false
		end
	end

	local stack = {}
	local read = 0
	local write = 0
	write=write + 1  stack[write] = {x,y} -- push
	visited[x][y] = true
	local dir={{x=-1,y=0},{x=1,y=0},{x=0,y=-1},{x=0,y=1} }

	while write > read do

		-- pull currently visited node
		read=read + 1  local coord = stack[read]  -- pull
		local vx = coord[1]
		local vy = coord[2]

		-- position matching all criteria?
		if accept_target(vx,vy) then
			add(targets,{x=vx, y=vy })
			if #targets==limit then
				return targets
			end
		end

		-- go visit neighboars
		for d in all(dir) do

			-- child position
			local cx = (vx+d.x)%48 -- map wrap
			local cy = (vy+d.y)%48
			if not visited[cx][cy] then
				visited[cx][cy]=true
				if accept_child(cx,cy) then
					write=write + 1  stack[write] = { cx, cy } -- push
				end
			end
		end
	end

	return targets
end