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
- You can resolve by its id, eg: tiles[3].name
- you can iterate over all enum entries like: for item in all(items) do print(item.name) end
- You can offset the ids by using tiles=enum(names, 10). Useful if your sprites start at index 10.
- You can also map arbitrary ids to objects like furniture=enum({[15]="table", [20]="chair"}).
- You can use the generated objects as a starting point for more complex objects like furniture.table.heavy=true,
or attach functionality like:

	actions.look.execute = function(item)
		print("Looks like a usual "..item.name)
	end
	actions.take.execute = function(item)
		if not target.heavy then add(inventory, item) end
	end
	function onactionuse(action, item)
		action.execute(item)
	end

Keep in mind that the usage of enums consumes more tokens than using magic numbers.
It's a trade off between tokens and elegant code.

]]--

function enum(names, offset)
	if offset==nil then offset=1 end
	local objects = {}
	for id,name in pairs(names) do
		id = id + offset - 1
		local obj = {id=id, name=name}
		objects[name] = obj
		objects[id] = obj
	end
	return objects
end
