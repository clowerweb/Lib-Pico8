-- makes a list of empty tiles on a map
-- checks for flag 0 on a tile

-- Contributors: Scathe (@clowerweb)

function empty_tiles(f)
 local cols=(w-8)/8
 local rows=(h-8)/8
 local tiles={}

 for y=0,rows do
  for x=0,cols do
   if(not fget(mget(x+ox/8,y+oy/8),0)) then
    if(not f) then
     add(tiles,{x*8,y*8})
    else -- away from player
     if(dst(x*8,curp.x,y*8,curp.y)>=40) then
      add(tiles,{x*8,y*8})
     end
    end
   end
  end
 end

 return tiles
end
