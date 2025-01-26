local MP = core.get_modpath(core.get_current_modname())

dofile(MP .. "/cherry.lua")
dofile(MP .. "/autumn_forest.lua") 
dofile(MP .. "/frost_land.lua")

minetest.register_node(":skywars:chest_3", {
	description = "Tier 3 chest (Diamond)",
	tiles = {
		"skywars_diamondchest_top.png",
		"skywars_diamondchest_top.png",
		"default_chest_side.png",
		"default_chest_side.png",
		"default_chest_side.png",
		"default_chest_lock.png",
	},
	paramtype2 = "facedir",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node(":skywars:chest_2", {
	description = "Tier 2 chest (Mese)",
	tiles = {
		"skywars_mesechest_top.png",
		"skywars_mesechest_top.png",
		"default_chest_side.png",
		"default_chest_side.png",
		"default_chest_side.png",
		"default_chest_front.png",
	},
	paramtype2 = "facedir",
	sounds = default.node_sound_wood_defaults(),
})


minetest.register_node(":skywars:chest_1", {
	description = "Tier 1 chest (bronze)",
	tiles = {
		"skywars_commonchest_top.png",
		"skywars_commonchest_top.png",
		"default_chest_side.png",
		"default_chest_side.png",
		"default_chest_side.png",
		"default_chest_front.png",
	},
	paramtype2 = "facedir",
	sounds = default.node_sound_wood_defaults(),
})

