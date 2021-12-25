pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
function _init()
 cls()
	vehicles={}
	add_vehicle()
	target={x=100,y=100}
end

function _update60()
 foreach(vehicles,upd_vehicles)
 foreach(vehicles,seek)
end

function _draw()
 cls()
	foreach(vehicles,drw_vehicles)
	circfill(target.x,target.y,5,2)
end
-->8
function add_vehicle()
	add(vehicles,{
		c={x=20,y=20},
	 v={x=0.9,y=0},
	 a={x=0.0,y=0.02},
	 vmax=4,
		})
end

function drw_vehicles(obj)
	pset(obj.c.x,obj.c.y,8)
end

function upd_vehicles(obj)
 obj.c=v_addv(obj.c,obj.v)
 obj.v=v_addv(obj.v,obj.a)
end

function seek(obj)
	local desired = v_subv(target,obj.c)
end
-->8
--methods for handling math between 2d vectors
-- vectors are tables with x,y variables inside

-- contributors: warrenm

-- add v1 to v2

function v_addv( v1, v2 )
  return { x = v1.x + v2.x, y = v1.y + v2.y }
end

-- subtract v2 from v1
function v_subv( v1, v2 )
  return { x = v1.x - v2.x, y = v1.y - v2.y }
end

-- multiply v by scalar n
function v_mults( v, n )
  return { x = v.x * n, y = v.y * n }
end

-- divide v by scalar n
function v_divs( v, n )
  return { x = v.x / n, y = v.y / n }
end

-- gets magnitude of v, squared (faster than v_mag)
function v_magsqr( v )
  return ( v.x * v.x ) + ( v.y * v.y )
end

-- compute magnitude of v
function v_mag( v )
  return sqrt( ( v.x * v.x ) + ( v.y * v.y ) )
end

-- normalizes v into a unit vector
function v_normalize( v )
  local len = v_mag( v )
  return { x = v.x / len, y = v.y / len }
end

-- computes dot product between v1 and v2
function v_dot( v1, v2 )
   return ( v1.x * v2.x ) + ( v1.y * v2.y )
end

-- computes the reflection vector between vector v and normal n
-- note : assumes v and n are normalized
function v_reflect( v, n )
  local dot = v_dot( v, n )
  local wdnv = v_mults( v_mults( n, dot ), 2.0 )
  local refv = v_subv( v, wdnv )
  return refv
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
