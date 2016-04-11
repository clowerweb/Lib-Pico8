-- check if at intersection
-- useful for running logic only
-- when an object is at an intersection
-- to preserve CPU cycles

-- Contributors: Scathe (@clowerweb)

function int(a)
 return (flr(a.x)%8==0 and
         flr(a.y)%8==0)
end
