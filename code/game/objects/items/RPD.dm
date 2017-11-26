/*
CONTAINS:
RPD
*/

#define PAINT_MODE -2
#define EATING_MODE -1
#define ATMOS_MODE 0
#define METER_MODE 1
#define DISPOSALS_MODE 2

#define CATEGORY_ATMOS 0
#define CATEGORY_DISPOSALS 1


<<<<<<< HEAD
=======
//find the defines in code\_DEFINES\pipe_construction.dm
>>>>>>> ver2
GLOBAL_LIST_INIT(atmos_pipe_recipes, list(
	"Pipes" = list(
		new /datum/pipe_info/pipe("Pipe",				/obj/machinery/atmospherics/pipe/simple),
		new /datum/pipe_info/pipe("Manifold",			/obj/machinery/atmospherics/pipe/manifold),
		new /datum/pipe_info/pipe("Manual Valve",		/obj/machinery/atmospherics/components/binary/valve),
		new /datum/pipe_info/pipe("Digital Valve",		/obj/machinery/atmospherics/components/binary/valve/digital),
		new /datum/pipe_info/pipe("4-Way Manifold",		/obj/machinery/atmospherics/pipe/manifold4w),
		new /datum/pipe_info/pipe("Layer Manifold",		/obj/machinery/atmospherics/pipe/layer_manifold),
	),
	"Devices" = list(
		new /datum/pipe_info/pipe("Connector",			/obj/machinery/atmospherics/components/unary/portables_connector),
		new /datum/pipe_info/pipe("Unary Vent",			/obj/machinery/atmospherics/components/unary/vent_pump),
		new /datum/pipe_info/pipe("Gas Pump",			/obj/machinery/atmospherics/components/binary/pump),
		new /datum/pipe_info/pipe("Passive Gate",		/obj/machinery/atmospherics/components/binary/passive_gate),
		new /datum/pipe_info/pipe("Volume Pump",		/obj/machinery/atmospherics/components/binary/volume_pump),
		new /datum/pipe_info/pipe("Scrubber",			/obj/machinery/atmospherics/components/unary/vent_scrubber),
		new /datum/pipe_info/pipe("Injector",			/obj/machinery/atmospherics/components/unary/outlet_injector),
		new /datum/pipe_info/meter("Meter"),
		new /datum/pipe_info/pipe("Gas Filter",			/obj/machinery/atmospherics/components/trinary/filter),
		new /datum/pipe_info/pipe("Gas Mixer",			/obj/machinery/atmospherics/components/trinary/mixer),
	),
	"Heat Exchange" = list(
		new /datum/pipe_info/pipe("Pipe",				/obj/machinery/atmospherics/pipe/heat_exchanging/simple),
		new /datum/pipe_info/pipe("Manifold",			/obj/machinery/atmospherics/pipe/heat_exchanging/manifold),
		new /datum/pipe_info/pipe("4-Way Manifold",		/obj/machinery/atmospherics/pipe/heat_exchanging/manifold4w),
		new /datum/pipe_info/pipe("Junction",			/obj/machinery/atmospherics/pipe/heat_exchanging/junction),
		new /datum/pipe_info/pipe("Heat Exchanger",		/obj/machinery/atmospherics/components/unary/heat_exchanger),
	)
))

GLOBAL_LIST_INIT(disposal_pipe_recipes, list(
	"Disposal Pipes" = list(
		new /datum/pipe_info/disposal("Pipe",			/obj/structure/disposalpipe/segment, PIPE_BENDABLE),
		new /datum/pipe_info/disposal("Junction",		/obj/structure/disposalpipe/junction, PIPE_TRIN_M),
		new /datum/pipe_info/disposal("Y-Junction",		/obj/structure/disposalpipe/junction/yjunction),
		new /datum/pipe_info/disposal("Sort Junction",	/obj/structure/disposalpipe/sorting/mail, PIPE_TRIN_M),
		new /datum/pipe_info/disposal("Trunk",			/obj/structure/disposalpipe/trunk),
		new /datum/pipe_info/disposal("Bin",			/obj/machinery/disposal/bin, PIPE_ONEDIR),
		new /datum/pipe_info/disposal("Outlet",			/obj/structure/disposaloutlet),
		new /datum/pipe_info/disposal("Chute",			/obj/machinery/disposal/deliveryChute),
	)
))


/datum/pipe_info
	var/name
<<<<<<< HEAD
	var/icon_state
	var/id = -1
	var/dirtype = PIPE_BENDABLE

/datum/pipe_info/proc/Render(dispenser)
	var/dat = "<li><a href='?src=[REF(dispenser)]&[Params()]'>[name]</a></li>"

	// Stationary pipe dispensers don't allow you to pre-select pipe directions.
	// This makes it impossble to spawn bent versions of bendable pipes.
	// We add a "Bent" pipe type with a preset diagonal direction to work around it.
	if(istype(dispenser, /obj/machinery/pipedispenser) && (dirtype == PIPE_BENDABLE || dirtype == /obj/item/pipe/binary/bendable))
		dat += "<li><a href='?src=[REF(dispenser)]&[Params()]&dir=[NORTHEAST]'>Bent [name]</a></li>"

	return dat

/datum/pipe_info/proc/Params()
	return ""

/datum/pipe_info/proc/get_preview(selected_dir)
	var/list/dirs
	switch(dirtype)
		if(PIPE_STRAIGHT, PIPE_BENDABLE)
			dirs = list("[NORTH]" = "Vertical", "[EAST]" = "Horizontal")
			if(dirtype == PIPE_BENDABLE)
				dirs += list("[NORTHWEST]" = "West to North", "[NORTHEAST]" = "North to East",
							 "[SOUTHWEST]" = "South to West", "[SOUTHEAST]" = "East to South")
		if(PIPE_TRINARY, PIPE_TRIN_M)
			dirs = list("[NORTH]" = "West South East", "[EAST]" = "North West South",
						"[SOUTH]" = "East North West", "[WEST]" = "South East North")
			if(dirtype == PIPE_TRIN_M)
				dirs += list("[SOUTHEAST]" = "West South East", "[NORTHEAST]" = "North West South",
							 "[NORTHWEST]" = "East North West", "[SOUTHWEST]" = "South East North")
		if(PIPE_UNARY)
			dirs = list("[NORTH]" = "North", "[EAST]" = "East", "[SOUTH]" = "South", "[WEST]" = "West")
		if(PIPE_ONEDIR)
			dirs = list("[SOUTH]" = name)

	var/list/rows = list()
	var/list/row = list("previews" = list())
	var/i = 0
	for(var/dir in dirs)
		var/flipped = (dirtype == PIPE_TRIN_M) && (text2num(dir) in GLOB.diagonals)
		row["previews"] += list(list("selected" = (text2num(dir) == selected_dir), "dir" = dir2text(text2num(dir)), "dir_name" = dirs[dir], "icon_state" = icon_state, "flipped" = flipped))
		if(i++ || dirtype == PIPE_ONEDIR)
			rows += list(row)
			row = list("previews" = list())
			i = 0

	return rows

=======
	var/icon
	var/icon_state
	var/id = -1
	var/categoryId
	var/dirtype = PIPE_BENDABLE

/datum/pipe_info/proc/Render(dispenser)
	return "<li><a href='?src=[REF(dispenser)]&[Params()]'>[name]</a></li>"

/datum/pipe_info/proc/Params()
	return ""


/datum/pipe_info/pipe
	categoryId = CATEGORY_ATMOS
	icon = 'icons/obj/atmospherics/pipes/pipe_item.dmi'

>>>>>>> ver2
/datum/pipe_info/pipe/New(label, obj/machinery/atmospherics/path)
	name = label
	id = path
	icon_state = initial(path.pipe_state)
	var/obj/item/pipe/c = initial(path.construction_type)
	dirtype = initial(c.RPD_type)

/datum/pipe_info/pipe/Params()
	return "makepipe=[id]&type=[dirtype]"
<<<<<<< HEAD
=======

>>>>>>> ver2

/datum/pipe_info/meter
	icon_state = "meterX"
	dirtype = PIPE_ONEDIR

/datum/pipe_info/meter/New(label)
	name = label

<<<<<<< HEAD
/datum/pipe_info/meter/Params()
	return "makemeter=[id]&type=[dirtype]"
=======
/datum/pipe_info/meter/New(label)
	name = label

/datum/pipe_info/meter/Params()
	return "makemeter=1&type=[dirtype]"


/datum/pipe_info/disposal
	categoryId = CATEGORY_DISPOSALS
	icon = 'icons/obj/atmospherics/pipes/disposal.dmi'
>>>>>>> ver2

/datum/pipe_info/disposal/New(label, obj/path, dt=PIPE_UNARY)
	name = label
	id = path

	icon_state = initial(path.icon_state)
	if(ispath(path, /obj/structure/disposalpipe))
		icon_state = "con[icon_state]"

	dirtype = dt

/datum/pipe_info/disposal/Params()
	return "dmake=[id]&type=[dirtype]"
<<<<<<< HEAD
=======

>>>>>>> ver2


/obj/item/pipe_dispenser
	name = "Rapid Piping Device (RPD)"
	desc = "A device used to rapidly pipe things."
	icon = 'icons/obj/tools.dmi'
	icon_state = "rpd"
	flags_1 = CONDUCT_1
	force = 10
	throwforce = 10
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	materials = list(MAT_METAL=75000, MAT_GLASS=37500)
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 100, acid = 50)
	resistance_flags = FIRE_PROOF
	var/datum/effect_system/spark_spread/spark_system
	var/working = 0
<<<<<<< HEAD
	var/mode = ATMOS_MODE
	var/p_dir = NORTH
	var/p_flipped = FALSE
=======
	var/p_type = /obj/machinery/atmospherics/pipe/simple
	var/p_conntype = PIPE_BENDABLE
	var/p_dir = 1
	var/p_flipped = FALSE
	var/p_class = ATMOS_MODE
>>>>>>> ver2
	var/list/paint_colors = list(
		"Grey"		= rgb(255,255,255),
		"Red"		= rgb(255,0,0),
		"Blue"		= rgb(0,0,255),
		"Cyan"		= rgb(0,256,249),
		"Green"		= rgb(30,255,0),
		"Yellow"	= rgb(255,198,0),
		"Purple"	= rgb(130,43,255)
	)
	var/paint_color="Grey"
	var/screen = CATEGORY_ATMOS //Starts on the atmos tab.
	var/piping_layer = PIPING_LAYER_DEFAULT
	var/datum/pipe_info/recipe
	var/static/datum/pipe_info/first_atmos
	var/static/datum/pipe_info/first_disposal

/obj/item/pipe_dispenser/New()
	. = ..()
	spark_system = new /datum/effect_system/spark_spread
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)
	if(!first_atmos)
		first_atmos = GLOB.atmos_pipe_recipes[GLOB.atmos_pipe_recipes[1]][1]
	if(!first_disposal)
		first_disposal = GLOB.disposal_pipe_recipes[GLOB.disposal_pipe_recipes[1]][1]
	recipe = first_atmos

/obj/item/pipe_dispenser/Destroy()
	qdel(spark_system)
	spark_system = null
	return ..()

/obj/item/pipe_dispenser/attack_self(mob/user)
	ui_interact(user)

/obj/item/pipe_dispenser/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] points the end of the RPD down [user.p_their()] throat and presses a button! It looks like [user.p_theyre()] trying to commit suicide...</span>")
	playsound(get_turf(user), 'sound/machines/click.ogg', 50, 1)
	playsound(get_turf(user), 'sound/items/deconstruct.ogg', 50, 1)
	return(BRUTELOSS)

<<<<<<< HEAD
/obj/item/pipe_dispenser/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, \
									datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		var/datum/asset/assets = get_asset_datum(/datum/asset/simple/icon_states/multiple_icons/pipes)
		assets.send(user)

		ui = new(user, src, ui_key, "rpd", name, 300, 550, master_ui, state)
		ui.open()

/obj/item/pipe_dispenser/ui_data(mob/user)
	var/list/data = list(
		"mode" = mode,
		"screen" = screen,
		"piping_layer" = piping_layer,
		"preview_rows" = recipe.get_preview(p_dir),
		"categories" = list(),
		"paint_colors" = list()
	)

	var/list/recipes
	if(screen == ATMOS_MODE)
		recipes = GLOB.atmos_pipe_recipes
	else if(screen == DISPOSALS_MODE)
		recipes = GLOB.disposal_pipe_recipes
	for(var/c in recipes)
		var/list/cat = recipes[c]
		var/list/r = list()
		for(var/i in 1 to cat.len)
			var/datum/pipe_info/info = cat[i]
			r += list(list("pipe_name" = info.name, "pipe_index" = i, "selected" = (info == recipe)))
		data["categories"] += list(list("cat_name" = c, "recipes" = r))

	data["paint_colors"] = list()
	for(var/c in paint_colors)
		data["paint_colors"] += list(list("color_name" = c, "color_hex" = paint_colors[c], "selected" = (c == paint_color)))

	return data

/obj/item/pipe_dispenser/ui_act(action, params)
	if(..())
		return
=======
/obj/item/pipe_dispenser/proc/render_dir_img(_dir,pic,title,flipped=0)
	var/selected=" class=\"imglink\""
	if(_dir == p_dir)
		selected=" class=\"imglink selected\""
	return "<a href=\"?src=[REF(src)];setdir=[_dir];flipped=[flipped]\" title=\"[title]\"[selected]\"><img src=\"[pic]\" /></a>"


/obj/item/pipe_dispenser/proc/show_menu(mob/user)
	if(!user || !src)
		return 0
	var/dat = {"<h2>Type</h2>
<b>Utilities:</b>
<ul>"}
	if(p_class != EATING_MODE)
		dat += "<li><a href='?src=[REF(src)];eatpipes=1;type=-1'>Eat Pipes</a></li>"
	else
		dat += "<li><span class='linkOn'>Eat Pipes</span></li>"
	if(p_class != PAINT_MODE)
		dat += "<li><a href='?src=[REF(src)];paintpipes=1;type=-1'>Paint Pipes</a></li>"
	else
		dat += "<li><span class='linkOn'>Paint Pipes</span></li>"
	dat += "</ul>"

	dat += "<b>Category:</b><ul>"
	if(screen == CATEGORY_ATMOS)
		var/list/recipes = GLOB.disposal_pipe_recipes
		var/datum/pipe_info/first_recipe = recipes[recipes[1]][1]
		dat += "<span class='linkOn'>Atmospherics</span> "
		dat += "<A href='?src=[REF(src)]&screen=[CATEGORY_DISPOSALS]&[first_recipe.Params()]'>Disposals</A><BR>"
		dat += "Atmospherics Piping Layer: "

		var/layers_total = PIPING_LAYER_MAX - PIPING_LAYER_MIN + 1
		for(var/iter = PIPING_LAYER_MIN, iter <= layers_total, iter++)
			if(iter == piping_layer)
				dat += "<span class='linkOn'>[iter]</span>"
			else
				dat += "<A href='?src=[REF(src)];setlayer=[iter]'>[iter]</A>"
		dat += "<BR>"

	else if(screen == CATEGORY_DISPOSALS)
		var/list/recipes = GLOB.atmos_pipe_recipes
		var/datum/pipe_info/first_recipe = recipes[recipes[1]][1]
		dat += "<A href='?src=[REF(src)]&screen=[CATEGORY_ATMOS]&[first_recipe.Params()]'>Atmospherics</A> "
		dat += "<span class='linkOn'>Disposals</span><BR>"

	dat += "</ul>"

	var/icon/preview=null
	var/datbuild = ""
	var/recipes = GLOB.atmos_pipe_recipes + GLOB.disposal_pipe_recipes
	for(var/category in recipes)
		var/list/cat_recipes = recipes[category]
		for(var/i in cat_recipes)
			var/datum/pipe_info/I = i
			var/found=0
			if(I.id == p_type)
				if((p_class == ATMOS_MODE || p_class == METER_MODE) && I.categoryId == CATEGORY_ATMOS)
					found = 1
				else if(p_class == DISPOSALS_MODE && I.categoryId == CATEGORY_DISPOSALS)
					found = 1
			if(found)
				preview = new /icon(I.icon, I.icon_state)
			if(screen == I.categoryId)
				if(I.id == p_type && p_class >= 0)
					datbuild += "<li><span class='linkOn'>[I.name]</span></li>"
				else
					datbuild += I.Render(src)

		if(length(datbuild) > 0)
			dat += "<b>[category]:</b><ul>"
			dat += datbuild
			datbuild = ""
		dat += "</ul>"

	var/color_css=""
	var/color_picker=""
	for(var/color_name in paint_colors)
		var/color=paint_colors[color_name]
		color_css += {"
			a.color.[color_name] {
				color: [color];
			}
			a.color.[color_name]:hover {
				border:1px solid [color];
			}
			a.color.[color_name].selected {
				background-color: [color];
			}
		"}
		var/selected=""
		if(color_name==paint_color)
			selected = " selected"
		color_picker += {"<a class="color [color_name][selected]" href="?src=[REF(src)];set_color=[color_name]">&bull;</a>"}

	var/dirsel="<h2>Direction</h2>"
	switch(p_conntype)
		if(-1)
			if(p_class==PAINT_MODE)
				dirsel = "<h2>Color</h2>[color_picker]"
			else
				dirsel = ""

		if(PIPE_STRAIGHT) // Straight, N-S, W-E
			if(preview)
				user << browse_rsc(new /icon(preview, dir=NORTH), "vertical.png")
				user << browse_rsc(new /icon(preview, dir=EAST), "horizontal.png")

				dirsel += "<p>"
				dirsel += render_dir_img(NORTH,"vertical.png","Vertical")
				dirsel += render_dir_img(EAST,"horizontal.png","Horizontal")
				dirsel += "</p>"
			else
				dirsel+={"
		<p>
			<a href="?src=[REF(src)];setdir=[NORTH]" title="vertical">&#8597;</a>
			<a href="?src=[REF(src)];setdir=[EAST]" title="horizontal">&harr;</a>
		</p>
				"}

		if(PIPE_BENDABLE) // Bent, N-W, N-E etc
			if(preview)
				user << browse_rsc(new /icon(preview, dir=NORTH), "vertical.png")
				user << browse_rsc(new /icon(preview, dir=EAST), "horizontal.png")
				user << browse_rsc(new /icon(preview, dir=NORTHWEST),  "nw.png")
				user << browse_rsc(new /icon(preview, dir=NORTHEAST),  "ne.png")
				user << browse_rsc(new /icon(preview, dir=SOUTHWEST),  "sw.png")
				user << browse_rsc(new /icon(preview, dir=SOUTHEAST),  "se.png")

				dirsel += "<p>"
				dirsel += render_dir_img(NORTH,"vertical.png","Vertical")
				dirsel += render_dir_img(EAST,"horizontal.png","Horizontal")
				dirsel += "<br />"
				dirsel += render_dir_img(NORTHWEST,"nw.png","West to North")
				dirsel += render_dir_img(NORTHEAST,"ne.png","North to East")
				dirsel += "<br />"
				dirsel += render_dir_img(SOUTHWEST,"sw.png","South to West")
				dirsel += render_dir_img(SOUTHEAST,"se.png","East to South")
				dirsel += "</p>"
			else
				dirsel+={"
		<p>
			<a href="?src=[REF(src)];setdir=[NORTH]" title="vertical">&#8597;</a>
			<a href="?src=[REF(src)];setdir=[EAST]" title="horizontal">&harr;</a>
			<br />
			<a href="?src=[REF(src)];setdir=[NORTHWEST]" title="West to North">&#9565;</a>
			<a href="?src=[REF(src)];setdir=[NORTHEAST]" title="North to East">&#9562;</a>
			<br />
			<a href="?src=[REF(src)];setdir=[SOUTHWEST]" title="South to West">&#9559;</a>
			<a href="?src=[REF(src)];setdir=[SOUTHEAST]" title="East to South">&#9556;</a>
		</p>
				"}
		if(PIPE_TRINARY) // Manifold
			if(preview)
				user << browse_rsc(new /icon(preview, dir=NORTH), "s.png")
				user << browse_rsc(new /icon(preview, dir=EAST),  "w.png")
				user << browse_rsc(new /icon(preview, dir=SOUTH), "n.png")
				user << browse_rsc(new /icon(preview, dir=WEST),  "e.png")

				dirsel += "<p>"
				dirsel += render_dir_img(NORTH,"s.png","West South East")
				dirsel += render_dir_img(EAST,"w.png","North West South")
				dirsel += "<br />"
				dirsel += render_dir_img(SOUTH,"n.png","East North West")
				dirsel += render_dir_img(WEST,"e.png","South East North")
				dirsel += "</p>"
			else
				dirsel+={"
		<p>
			<a href="?src=[REF(src)];setdir=[NORTH]" title="West, South, East">&#9574;</a>
			<a href="?src=[REF(src)];setdir=[EAST]" title="North, West, South">&#9571;</a>
			<br />
			<a href="?src=[REF(src)];setdir=[SOUTH]" title="East, North, West">&#9577;</a>
			<a href="?src=[REF(src)];setdir=[WEST]" title="South, East, North">&#9568;</a>
		</p>
				"}
		if(PIPE_TRIN_M) // Mirrored ones
			if(preview)
				user << browse_rsc(new /icon(preview, dir=NORTH), "s.png")
				user << browse_rsc(new /icon(preview, dir=EAST),  "w.png")
				user << browse_rsc(new /icon(preview, dir=SOUTH), "n.png")
				user << browse_rsc(new /icon(preview, dir=WEST),  "e.png")
				user << browse_rsc(new /icon(preview, dir=SOUTHEAST), "sm.png") //each mirror icon is 45 anticlockwise from it's real direction
				user << browse_rsc(new /icon(preview, dir=NORTHEAST),  "wm.png")
				user << browse_rsc(new /icon(preview, dir=NORTHWEST), "nm.png")
				user << browse_rsc(new /icon(preview, dir=SOUTHWEST),  "em.png")

				dirsel += "<p>"
				dirsel += render_dir_img(NORTH,"s.png","West South East")
				dirsel += render_dir_img(EAST,"w.png","North West South")
				dirsel += "<br />"
				dirsel += render_dir_img(SOUTH,"n.png","East North West")
				dirsel += render_dir_img(WEST,"e.png","South East North")
				dirsel += "<br />"
				dirsel += render_dir_img(SOUTHEAST,"sm.png","West South East", 1)
				dirsel += render_dir_img(NORTHEAST,"wm.png","North West South", 1)
				dirsel += "<br />"
				dirsel += render_dir_img(NORTHWEST,"nm.png","East North West", 1)
				dirsel += render_dir_img(SOUTHWEST,"em.png","South East North", 1)
				dirsel += "</p>"
			else
				dirsel+={"
		<p>
			<a href="?src=[REF(src)];setdir=[NORTH]" title="West, South, East">&#9574;</a>
			<a href="?src=[REF(src)];setdir=[EAST]" title="North, West, South">&#9571;</a>
			<br />
			<a href="?src=[REF(src)];setdir=[SOUTH]" title="East, North, West">&#9577;</a>
			<a href="?src=[REF(src)];setdir=[WEST]" title="South, East, North">&#9568;</a>
			<br />
			<a href="?src=[REF(src)];setdir=[SOUTHEAST];flipped=1" title="West, South, East">&#9574;</a>
			<a href="?src=[REF(src)];setdir=[NORTHEAST];flipped=1" title="North, West, South">&#9571;</a>
			<br />
			<a href="?src=[REF(src)];setdir=[NORTHWEST];flipped=1" title="East, North, West">&#9577;</a>
			<a href="?src=[REF(src)];setdir=[SOUTHWEST];flipped=1" title="South, East, North">&#9568;</a>
		</p>
				"}
		if(PIPE_UNARY) // Stuff with four directions - includes pumps etc.
			if(preview)
				user << browse_rsc(new /icon(preview, dir=NORTH), "n.png")
				user << browse_rsc(new /icon(preview, dir=EAST),  "e.png")
				user << browse_rsc(new /icon(preview, dir=SOUTH), "s.png")
				user << browse_rsc(new /icon(preview, dir=WEST),  "w.png")

				dirsel += "<p>"
				dirsel += render_dir_img(NORTH,"n.png","North")
				dirsel += render_dir_img(EAST, "e.png","East")
				dirsel += render_dir_img(SOUTH,"s.png","South")
				dirsel += render_dir_img(WEST, "w.png","West")
				dirsel += "</p>"
			else
				dirsel+={"
		<p>
			<a href="?src=[REF(src)];setdir=[NORTH]" title="North">&uarr;</a>
			<a href="?src=[REF(src)];setdir=[EAST]" title="East">&rarr;</a>
			<a href="?src=[REF(src)];setdir=[SOUTH]" title="South">&darr;</a>
			<a href="?src=[REF(src)];setdir=[WEST]" title="West">&larr;</a>
		</p>
					"}
		if(PIPE_ONEDIR) // Single icon_state (eg 4-way manifolds)
			if(preview)
				user << browse_rsc(new /icon(preview), "pipe.png")

				dirsel += "<p>"
				dirsel += render_dir_img(SOUTH,"pipe.png","Pipe")
				dirsel += "</p>"
			else
				dirsel+={"
		<p>
			<a href="?src=[REF(src)];setdir=[SOUTH]" title="Pipe">&#8597;</a>
		</p>
				"}


	var/datsytle = {"
<style type="text/css">
	a.imglink {
		padding: none;
		text-decoration:none;
		border-style:none;
		background:none;
		margin: 1px;
	}

	a.imglink:hover {
		background:none;
		color:none;
	}

	a.imglink.selected img {
		border: 1px solid #24722e;
		background: #2f943c;
	}

	a img {
		border: 1px solid #161616;
		background: #40628a;
	}

	a.color {
		padding: 5px 10px;
		font-size: large;
		font-weight: bold;
		border: 1px solid #161616;
	}

	a.selected img,
		a:hover {
			background: #0066cc;
			color: #ffffff;
		}
		[color_css]
</style>"}

	dat = datsytle + dirsel + dat

	var/datum/browser/popup = new(user, "pipedispenser", name, 300, 550)
	popup.set_content(dat)
	popup.open()
	return

/obj/item/pipe_dispenser/Topic(href, href_list)
>>>>>>> ver2
	if(!usr.canUseTopic(src))
		return
<<<<<<< HEAD
	var/playeffect = TRUE
	switch(action)
		if("color")
			paint_color = params["paint_color"]
		if("mode")
			mode = text2num(params["mode"])
		if("screen")
			if(mode == screen)
				mode = text2num(params["screen"])
			screen = text2num(params["screen"])
			recipe = screen == DISPOSALS_MODE ? first_disposal : first_atmos
			p_dir = NORTH
			playeffect = FALSE
		if("piping_layer")
			piping_layer = text2num(params["piping_layer"])
			playeffect = FALSE
		if("pipe_type")
			var/static/list/recipes
			if(!recipes)
				recipes = GLOB.disposal_pipe_recipes + GLOB.atmos_pipe_recipes
			recipe = recipes[params["category"]][text2num(params["pipe_type"])]
			p_dir = NORTH
		if("setdir")
			p_dir = text2dir(params["dir"])
			p_flipped = text2num(params["flipped"])
			playeffect = FALSE
	if(playeffect)
		spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
=======
	usr.set_machine(src)
	add_fingerprint(usr)
	if(href_list["screen"])
		screen = text2num(href_list["screen"])
		show_menu(usr)

	if(href_list["setdir"])
		p_dir = text2num(href_list["setdir"])
		if(href_list["flipped"])
			p_flipped = text2num(href_list["flipped"])
		else
			p_flipped = FALSE
		show_menu(usr)

	if(href_list["setlayer"])
		if(!isnum(href_list["setlayer"]))
			piping_layer = text2num(href_list["setlayer"])
		else
			piping_layer = href_list["setlayer"]
		show_menu(usr)

	if(href_list["eatpipes"])
		p_class = EATING_MODE
		p_conntype=-1
		p_dir=1
		spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
		show_menu(usr)

	if(href_list["paintpipes"])
		p_class = PAINT_MODE
		p_conntype = -1
		p_dir = 1
		spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
		show_menu(usr)

	if(href_list["set_color"])
		paint_color = href_list["set_color"]
		spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
		show_menu(usr)

	if(href_list["makepipe"])
		p_type = text2path(href_list["makepipe"])
		var/obj/item/pipe/path = text2path(href_list["type"])
		p_conntype = initial(path.RPD_type)
		p_dir = NORTH
		p_class = ATMOS_MODE
		spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
		show_menu(usr)

	if(href_list["makemeter"])
		p_class = METER_MODE
		p_conntype = -1
		p_dir = NORTH
		spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
		show_menu(usr)

	if(href_list["dmake"])
		p_type = text2path(href_list["dmake"])
		p_conntype = text2num(href_list["type"])
		p_dir = NORTH
		p_class = DISPOSALS_MODE
		spark_system.start()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
		show_menu(usr)

>>>>>>> ver2

/obj/item/pipe_dispenser/pre_attackby(atom/A, mob/user)
	if(!user.IsAdvancedToolUser() || istype(A, /turf/open/space/transit))
		return ..()

	var/atmos_piping_mode = mode == ATMOS_MODE || mode == METER_MODE
	var/temp_piping_layer
	if(atmos_piping_mode)
		if(istype(A, /obj/machinery/atmospherics))
			var/obj/machinery/atmospherics/AM = A
			temp_piping_layer = AM.piping_layer
			A = get_turf(user)

<<<<<<< HEAD
	var/static/list/make_pipe_whitelist
	if(!make_pipe_whitelist)
		make_pipe_whitelist = list(/obj/structure/lattice, /obj/structure/girder, /obj/item/pipe)

	//make sure what we're clicking is valid for the current mode
	var/can_make_pipe = (atmos_piping_mode || mode == DISPOSALS_MODE) && (isturf(A) || is_type_in_list(A, make_pipe_whitelist))

=======
	//make sure what we're clicking is valid for the current mode
	var/can_make_pipe = ((atmos_piping_mode || p_class == DISPOSALS_MODE) && (isturf(A)) || istype(A, /obj/structure/lattice) || istype(A, /obj/structure/girder))

>>>>>>> ver2
	//So that changing the menu settings doesn't affect the pipes already being built.
	var/queued_p_type = recipe.id
	var/queued_p_dir = p_dir
	var/queued_p_flipped = p_flipped

	. = FALSE
	switch(mode) //if we've gotten this var, the target is valid
		if(PAINT_MODE) //Paint pipes
			if(!istype(A, /obj/machinery/atmospherics/pipe))
				return ..()
			var/obj/machinery/atmospherics/pipe/P = A
			playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
			P.paint(paint_colors[paint_color])
			user.visible_message("<span class='notice'>[user] paints \the [P] [paint_color].</span>","<span class='notice'>You paint \the [P] [paint_color].</span>")
			return

		if(EATING_MODE) //Eating pipes
			if(!(istype(A, /obj/item/pipe) || istype(A, /obj/item/pipe_meter) || istype(A, /obj/structure/disposalconstruct)))
				return ..()
			to_chat(user, "<span class='notice'>You start destroying a pipe...</span>")
			playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
			if(do_after(user, 2, target = A))
				activate()
				qdel(A)

		if(ATMOS_MODE) //Making pipes
			if(!can_make_pipe)
				return ..()
			to_chat(user, "<span class='notice'>You start building a pipe...</span>")
			playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
			if(do_after(user, 2, target = A))
				activate()

				var/obj/machinery/atmospherics/path = queued_p_type
				var/pipe_item_type = initial(path.construction_type) || /obj/item/pipe

				var/obj/item/pipe/P = new pipe_item_type(A, queued_p_type, queued_p_dir)

				if(queued_p_flipped)
					var/obj/item/pipe/trinary/flippable/F = P
					F.flipped = queued_p_flipped

				P.update()
				P.add_fingerprint(usr)
				if(!isnull(temp_piping_layer))
					P.setPipingLayer(temp_piping_layer)
				else
					P.setPipingLayer(piping_layer)
				P.add_atom_colour(paint_colors[paint_color], FIXED_COLOUR_PRIORITY)

		if(METER_MODE) //Making pipe meters
			if(!can_make_pipe)
				return ..()
			to_chat(user, "<span class='notice'>You start building a meter...</span>")
			playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
			if(do_after(user, 2, target = A))
				activate()
				var/obj/item/pipe_meter/PM = new /obj/item/pipe_meter(get_turf(A))
				if(!isnull(temp_piping_layer))
					PM.setAttachLayer(temp_piping_layer)
				else
					PM.setAttachLayer(piping_layer)

		if(DISPOSALS_MODE) //Making disposals pipes
			if(!can_make_pipe)
				return ..()
			if(isclosedturf(A))
				to_chat(user, "<span class='warning'>[src]'s error light flickers; there's something in the way!</span>")
				return
			to_chat(user, "<span class='notice'>You start building a disposals pipe...</span>")
			playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
			if(do_after(user, 4, target = A))
				var/obj/structure/disposalconstruct/C = new (A, queued_p_type, queued_p_dir, queued_p_flipped)

				if(!C.can_place())
					to_chat(user, "<span class='warning'>There's not enough room to build that here!</span>")
					qdel(C)
					return

				activate()

				C.add_fingerprint(usr)
				C.update_icon()
				return

		else
			return ..()


/obj/item/pipe_dispenser/proc/activate()
	playsound(get_turf(src), 'sound/items/deconstruct.ogg', 50, 1)

#undef PAINT_MODE
#undef EATING_MODE
#undef ATMOS_MODE
#undef METER_MODE
#undef DISPOSALS_MODE
#undef CATEGORY_ATMOS
#undef CATEGORY_DISPOSALS
