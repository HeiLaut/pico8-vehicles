pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
function _init()
 cls()
	vehicles={}
	attractors={}
	for i =1 , 60 do
			add_vehicle()
	end
	for i=1, 2 do
		add_attractor()
	end
	a=attractors[1]
	
end

function _update60()
 foreach(vehicles,upd_vehicles)
 foreach(attractors,upd_vehicles)
 if(btn(⬆️))a.c.y-=2
 if(btn(⬇️))a.c.y+=2
 if(btn(⬅️))a.c.x-=2
 if(btn(➡️))a.c.x+=2
 if(btnp(❎))a.at=-1
 if(btnp(🅾️))a.at=1

end

function _draw()
 cls()
	foreach(vehicles,drw_vehicles)
	foreach(attractors,drw_attractor)
end
-->8
function add_vehicle()
	add(vehicles,{
		c={x=rnd(128),y=rnd(128)},
	 v={x=rnd(1),y=rnd(1)},
	 a={x=0,y=0},
	 vmax=rnd(1.5)+0.2,
		})
end

function add_attractor()
	add(attractors,{
		c={x=rnd(128),y=rnd(128)},
		at=rnd{-1,1},
	 v={x=rnd(1)-1,y=rnd(1)-1},
	 a={x=0,y=0},
	 //vmax=rnd(1.5)+0.2,
		})
end

function apply_force(obj,force)
	 obj.a=v_addv(obj.a,force)
	 
end

function drw_vehicles(obj)
	circfill(obj.c.x,obj.c.y,1,8)
	line(obj.c.x,obj.c.y,(obj.c.x+obj.v.x*4),(obj.c.y+4*obj.v.y),8)
end

function drw_attractor(obj)
	circfill(obj.c.x,obj.c.y,3,8-obj.at)
end

function steer(attr,obj)
	local desired=v_subv(attr.c,obj.c)
 local dist=v_mag(desired)
 desired=v_normalize(desired)
 desired=v_mults(desired,attr.at*obj.vmax)
 local steer=v_subv(desired,obj.v)
 steer.x=mid(-0.02,steer.x,0.02)
 steer.y=mid(-0.02,steer.y,0.02)
 apply_force(obj,steer)
end

function upd_vehicles(obj)
 obj.v=v_addv(obj.v,obj.a)
 obj.c=v_addv(obj.c,obj.v)
	obj.a.x, obj.a.y = 0,0
 if obj.at == nil then
 	for at in all(attractors) do
 		steer(at,obj)
 	end
// else
 	//obj.c.x=obj.c.x%128
 	//obj.c.y=obj.c.y%128
 end
 if(obj.c.x<0 or obj.c.x>128) obj.v.x*=-1
 if(obj.c.y<0 or obj.c.y>128) obj.v.y*=-1

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
