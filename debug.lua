--
-- various functions useful for debugging and profiling
--

-- Contributors: sulai

table={}
---
-- Use this for some basic memory profiling.
-- this function counts the number
-- of entities (deep), not bytes
-- @param t table to get the size of
-- @return size in number of entities (recursive)
function table.size(t)
	local size=0
	for _,v in pairs(t) do
		size=size+1
		if type(v)=="table" then
			size=size+table.size(v)
		end
	end
	return size
end

-- test
--print(table.size({true,1,{false,"---"}}))

--- converts anything to string
function tostring(any)
	if type(any)=="function" then return "function" end
	if any==nil then return "nil" end
	if type(any)=="string" then return any end
	if type(any)=="boolean" then return any and "true" or "false" end
	if type(any)=="number" then return ""..any end
	if type(any)=="table" then -- recursion
		local str = "{ "
		for k,v in pairs(any) do
			str=str..tostring(k).."->"..tostring(v).." "
		end
		return str.."}"
	end
	return "unkown" -- should never show
end

-- tests
--print(""..tostring({true,x=7,{"nest"}}))
--print(function() end)

--- do some basic cpu profiling
-- Example usage:
--
--   check_cpu()
--   ... do some intensive stuff ...
--   check_cpu("this took") -- log on system console
function check_cpu(msg)
	if msg==nil then check_cpu_start=stat(1) return end
	local percent = ((stat(1)-check_cpu_start)*100)
	printh(msg.." "..flr(percent).."% of a frame")
	return percent
end

-- tests
--check_cpu()
--for i = 1, 10000 do
--	printh("consume some time")
--end
--check_cpu("for loop")