--Methods for handling math between 2D vectors
-- Vectors are tables with x,y variables inside

-- Contributors: WarrenM

-- Add v1 to v2
function vec_addv(v1, v2)
  return {x=v1.x+v2.x, y=v1.y+v2.y}
end

-- Subtract v2 from v1
function vec_subv(v1,v2)
  return {x=v1.x-v2.x, y=v1.y-v2.y}
end

-- Multiply v by scalar n
function vec_mults(v,n)
  return {x=v.x*n, y=v.y*n}
end

-- Divide v by scalar n
function vec_divs(v, n)
  return {x=v.x/n, y=v.y/n}
end

-- Gets magnitude of v, squared (faster than vec_mag)
function vec_magsqr(v)
  return (v.x * v.x) + (v.y * v.y)
end

-- Compute magnitude of v
function vec_mag( v )
  return sqrt( (v.x * v.x) + (v.y * v.y) )
end

-- Computes distance between v1 and v2, squared.
function vec_distsqr(v1, v2)
  return (v1.x-v2.x) * (v1.x-v2.x) + (v1.y-v2.y) * (v1.y-v2.y)
end

-- Normalizes v into a unit vector
function vec_normalize( v )
  local len = vec_mag( v )
  return { x = v.x / len, y = v.y / len }
end

-- Computes dot product between v1 and v2
function dotv( v1, v2 )
   return (v1.x* v2.x) + (v1.y * v2.y)
end

-- Computes the reflection vector between vector v and normal n
-- NOTE : assumes v and n are normalized
function reflectv( v, n )
  local dot = dotv( v, n )
  local wdnv = multv( multv( n, dot ), 2.0 )
  local refv = subv( v, wdnv )
  return refv
end
