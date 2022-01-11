pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
function _init()
 cls()
	vehicles={}
	targets={}
	for i=1,200 do
		add_vehicle()
	end
	for i=1,2 do
		add_targets()
	end
	a=targets[1]

end

function _update60()
 foreach(vehicles,upd_vehicles)
 if(btn(➡️))a.x+=2
  if(btn(⬅️))a.x-=2
   if(btn(⬇️))a.y+=2
    if(btn(⬆️))a.y-=2
end

function _draw()
 cls()
	foreach(vehicles,drw_vehicles)
	foreach(targets,drw_targets)

end
-->8
function add_vehicle()
	add(vehicles,{
		c=vec(rnd(128),rnd(128)),
	 v=vec(rnd(1),rnd(1)),
	 a=vec(0,0),
	 vmax=4,
	 col=rnd(17),
	 m=rnd(5)
		})
end

function add_targets()
	add(targets,
		vec(rnd(90)+20,rnd(90)+20)
		)
end

function apply_force(obj,force)
		force=v_mults(force,10/obj.m)
	 obj.a=v_addv(obj.a,force)
	 
end

function calc_force(tar,obj)
	local vec=v_subv(tar,obj.c)
	local distsq=v_magsqr(vec)
	vec = v_normalize(vec)
	local a = v_mults(vec,10/(distsq))
	return a
	
end

function upd_vehicles(obj)
 obj.v=v_addv(obj.v,obj.a)
 obj.c=v_addv(obj.c,obj.v)
 obj.a=vec(0,0)

 for target in all(targets) do
	 apply_force(obj,calc_force(target,obj))
	end
end


function drw_vehicles(obj)
	circfill(obj.c.x,obj.c.y,obj.m/2,obj.col)
// line(obj.c.x,obj.c.y,(obj.c.x+obj.v.x*4),(obj.c.y+4*obj.v.y),obj.col)
end

function drw_targets(obj)
	circfill(obj.x,obj.y,2,7)
end
-->8
--methods for handling math between 2d vectors
-- vectors are tables with x,y variables inside

-- contributors: warrenm

-- add v1 to v2

function vec(x,y)
	return({x=x,y=y})
end

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
