-- general language features

-- Contributors: sulai


--[[

This function generates an enum structure from a list of names.

The generated structure is quite powerful when it comes to readability and object orientation.

As a use case for Pico-8, you can comfortably generate named objects that map to sprite ids.

Example usage in a RPG:

	tiles = enum( {"grass" ,"water", "rock"} )     -- landscape sprites start at 1
	items = enum( {"sword" ,"shield", "bow"}, 16 ) -- item sprites start at 16
	colors = enum( {"black", "blue", ... }, 0 )    -- map color palette.
	actions = enum( {"look", "take", ... } )       -- just an enum.

You can now use the enums to make your code more readable:

	if action==actions.take then
		mset(x,y,tiles.grass.id)
		pset(x,y,colors.green.id)
	end

- You can resolve to its name like tiles.water.name.
- You can resolve by its id, eg: tiles[3].name, or by name: tiles["water"].id
- You can offset the ids by using tiles=enum(names, 10). Useful if your sprites start at index 10.
- You can also map arbitrary ids to objects like furniture=enum({[15]="table", [20]="chair"}).
- you can iterate over all enum objects like: for item in items.all() do print(item.name) end
- you can get the amount of enum entries like: items.size
- You can use the generated objects as a starting point for more complex objects like furniture.table.heavy=true,
or attach functionality like:

	actions.look.execute = function(item)
		print("Looks like a usual "..item.name)
	end
	actions.take.execute = function(item)
		if not item.heavy then add(inventory, item) end
	end
	function onactionuse(action, item)
		action.execute(item)
	end

Keep in mind that the usage of enums consumes more tokens than using magic numbers.
It's a trade off between tokens and elegant code.

]]--

function enum(names, offset)
	offset=offset or 1
	local objects = {}
	local size=0
	for idr,name in pairs(names) do
		local id = idr + offset - 1
		local obj = {
			id=id,       -- id
			idr=idr,     -- 1-based relative id, without offset being added
			name=name    -- name of the object
		}
		objects[name] = obj
		objects[id] = obj
		size=size+1
	end
	objects.idstart = offset        -- start of the id range being used
	objects.idend = offset+size-1   -- end of the id range being used
	objects.size=size
	objects.all = function()
		local list = {}
		for _,name in pairs(names) do
			add(list,objects[name])
		end
		local i=0
		return function() i=i+1 if i<=#list then return list[i] end end
	end
	return objects
end