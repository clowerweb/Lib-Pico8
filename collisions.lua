-- general collision functions
-- there are several different ones,
-- which should suit most needs.
-- by Scathe (@clowerweb)

-- collisions with map tiles
function coll_map(o)
  local x1=o.x/8
  local y1=o.y/8
  local x2=(o.x+7)/8
  local y2=(o.y+7)/8
  local a=fget(mget(x1,y1),0)
  local b=fget(mget(x1,y2),0)
  local c=fget(mget(x2,y2),0)
  local d=fget(mget(x2,y1),0)
  return a or b or c or d
end

-- collision with world bounds
function coll_world(o,h,v)
  if(h and o.x<0 or o.x+o.width>world.w) then
    return true
  end
  if(v and o.y<0 or o.y+o.height>world.h) then
    return true
  end
end

-- collision with objects
function coll_obj(o1,o2)
 for k in pairs(o2) do
  if((a.x<=b[k].x+b[k].width) and
     (a.x+a.width>=b[k].x) and
     (a.y<=b[k].y+b[k].height) and
     (a.y+a.height>=b[k].y)) then
   -- returns the index of the object 
   -- you are colliding with
   return k
  end
 end
end

-- checks if two objects occupy the same tile
function coll_rough(a,b)
 local ax=flr((a.x+4)/8)*8
 local ay=flr((a.y+4)/8)*8
 local bx=flr((b.x+4)/8)*8
 local by=flr((b.y+4)/8)*8

 return ax==bx and ay==by
end

-- pixel perfect collision
-- coming soon!
