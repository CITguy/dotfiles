
--[[
Ring Meters by londonali1010 (2009)

This script draws percentage meters as rings. It is fully customisable; all options are described in the script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement on line 145 uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num>5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num>3; conversely if you update Conky every 0.5s, you should use update_num>10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
	lua_load ~/scripts/rings-v1.2.lua
	lua_draw_hook_pre ring_stats
	
Changelog:
+ v1.2 -- Added option for the ending angle of the rings (07.10.2009)
+ v1.1 -- Added options for the starting angle of the rings, and added the "max" variable, to allow for variables that output a numerical value rather than a percentage (29.09.2009)
+ v1.0 -- Original release (28.09.2009)
]]
-- Edit this table to customize your rings.
-- You can create more rings simply by adding more elements to settings_table.
		-- "name" is the type of stat to display; you can choose from 'cpu', 'memperc', 'fs_used_perc', 'battery_used_perc'.
		-- "arg" is the argument to the stat type, e.g. if in Conky you would write ${cpu cpu0}, 'cpu0' would be the argument. If you would not use an argument in the Conky variable, use ''.
		-- "max" is the maximum value of the ring. If the Conky variable outputs a percentage, use 100.
		-- "bg_colour" is the colour of the base ring.
		-- "bg_alpha" is the alpha value of the base ring.
		-- "fg_colour" is the colour of the indicator part of the ring.
		-- "fg_alpha" is the alpha value of the indicator part of the ring.
		-- "x" and "y" are the x and y coordinates of the centre of the ring, relative to the top left corner of the Conky window.
		-- "radius" is the radius of the ring.
		-- "thickness" is the thickness of the ring, centred around the radius.
		-- "start_angle" is the starting angle of the ring, in degrees, clockwise from top. Value can be either positive or negative.
		-- "end_angle" is the ending angle of the ring, in degrees, clockwise from top. Value can be either positive or negative, but must be larger (e.g. more clockwise) than start_angle.
settings_table = {
  { name="cpu", arg="cpu1", max=100, radius=075, start_angle=156, end_angle=339 },
  { name="cpu", arg="cpu2", max=100, radius=100, start_angle=-72, end_angle=106 },
  { name="cpu", arg="cpu3", max=100, radius=125, start_angle=61,  end_angle=239 },
  { name="cpu", arg="cpu4", max=100, radius=150, start_angle=176, end_angle=355 },
  { name="cpu", arg="cpu5", max=100, radius=175, start_angle=51,  end_angle=230 },
  { name="cpu", arg="cpu6", max=100, radius=200, start_angle=-47, end_angle=131 },
  { name="cpu", arg="cpu7", max=100, radius=225, start_angle=121, end_angle=301 },
  { name="cpu", arg="cpu8", max=100, radius=251, start_angle=-43, end_angle=135 }
}

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
  local w,h=conky_window.width,conky_window.height
	
  -- #############################################
  -- ##   COMMON VALUES
  -- #############################################
  -- x,y center (from top left of conky window)
  local xc,yc = 280, 281
  -- ring width
  local ring_w = 8 
  -- background color/alpha
  local bgc, bga = 0xffffff, 0.0
  -- foreground color/alpha
  local fgc, fga = 0xffff00, 1.0
  
  -- radius, start/end angle (different per ring)
  local ring_r,sa,ea=pt['radius'],pt['start_angle'],pt['end_angle']

  local angle_0=sa*(2*math.pi/360)-math.pi/2
  local angle_f=ea*(2*math.pi/360)-math.pi/2
  local t_arc=t*(angle_f-angle_0)

  -- Draw background ring
	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)
	
	-- Draw indicator ring
	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)		
end

function conky_ring_stats()
	local function setup_rings(cr,pt)
		local str=''
		local value=0
		
		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)
		
		value=tonumber(str)
    if value==nil then 
      pct = 0
    else
      pct=value/pt['max']
    end

    if pct > 1 then
      pct = 1
    elseif pct < 0 then
      pct = 0
    end
		
		draw_ring(cr,pct,pt)
	end

	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
	
	local cr=cairo_create(cs)	
	
	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)
	
	if update_num>10 then
		for i in pairs(settings_table) do
			setup_rings(cr,settings_table[i])
		end
	end
end
