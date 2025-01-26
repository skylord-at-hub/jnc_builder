local MP = core.get_modpath(core.get_current_modname())

-- Nodes

minetest.register_node(":skywars:frost_land_grass", {
	description = "Frosty Grass",
	tiles = {"forsty_grass_top.png", "default_dirt.png",
		{name = "default_dirt.png^frosty_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node(":skywars:frosty_leaves_1", {
	description = "Frosty Blue Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"frost_leaves_1.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"skywars:frost_land_sapling"}, rarity = 20},
			{items = {"skywars:frosty_leaves_1"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

})

minetest.register_node(":skywars:frost_land_leaves_2", {
	description = "Frosty Yellow Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"frost_leaves_2.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"skywars:frost_land_sapling"}, rarity = 20},
			{items = {"skywars:frost_land_leaves_2"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

})

minetest.register_node(":skywars:frost_land_wood", {
	description = "Frosty Wood",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"frost_land_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node(":skywars:frost_land_tree", {
	description = "Frosty Tree",
	tiles = {"frost_land_tree_top.png", "frost_land_tree_top.png",
		"frost_land_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

stairs.register_stair_and_slab("frost_land_wood", "skywars:frost_land_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	{"frost_land_wood.png"},
	"Frosty Wood Stair",
	"Frosty Wood Slab",
	default.node_sound_wood_defaults())


doors.register_fencegate("skywars:gate_frost_land", {
	description = "Frosty Wood Fence Gate",
	texture = "frost_land_wood_fence.png",
	material = "skywars:frost_land_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

default.register_fence(":skywars:fence_frost_land_wood", {
	description = "Frosty Wood Fence",
	texture = "frost_land_wood_fence.png",
	inventory_image = "default_fence_overlay.png^frost_land_wood_fence.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^frost_land_wood_fence.png^" ..
				"default_fence_overlay.png^[makealpha:255,126,126",
	material = "skywars:frost_land_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail(":skywars:fence_rail_frost_land_wood", {
	description = "Frosty Wood Fence Rail",
	texture = "frost_land_wood_fence.png",
	inventory_image = "default_fence_rail_overlay.png^frost_land_wood_fence.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_rail_overlay.png^frost_land_wood_fence.png^" ..
				"default_fence_rail_overlay.png^[makealpha:255,126,126",
	material = "skywars:frost_land_wood",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults()
})

-- Sapling
local schematic_offsets = {
	["frost_land_tree_1.mts"] = {x = -3, y = 0, z = -3},
	["frost_land_tree_2.mts"] = {x = - 3, y = 0, z = -3},
	["frost_land_tree_3.mts"] = {x = - 3, y = 0, z = -3},
}

local function grow_new_frost_land_tree(pos)
	if not default.can_grow(pos) then
		minetest.get_node_timer(pos):start(math.random(300, 1500))
		return
	end

	minetest.remove_node(pos)
	local random_tree = "frost_land_tree_" .. math.random(1, 3) .. ".mts"
	local offset = schematic_offsets[random_tree]
	minetest.place_schematic(
		{x = pos.x + offset.x, y = pos.y + offset.y, z = pos.z + offset.z},
		MP .. "/schems/" .. random_tree,
		"0",
		nil,
		false
	)
end

minetest.register_node(":skywars:frost_land_sapling", {
	description = "Frosty Sapling",
	drawtype = "plantlike",
	tiles = {"frost_land_sapling.png"},
	inventory_image = "frost_land_sapling.png",
	wield_image = "frost_land_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_frost_land_tree,
	selection_box = {
		type = "fixed",
		fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2, attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
			minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"skywars:frost_land_sapling",
			{x = -1, y = 0, z = -1},
			{x = 1, y = 3, z = 1},
			2 
		)

		return itemstack
	end,
})

if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"skywars:frost_land_sapling", grow_new_frost_land_tree, "soil"},
	})
end

default.register_leafdecay({
	trunks = {"skywars:frost_land_wood"},
	leaves = {"skywars:frosty_leaves_1", "skywars:frost_land_leaves_2"},
	radius = 3,
})

-- Crafts

minetest.register_craft({
	output = "skywars:frost_land_wood 4",
	recipe = {
		{"skywars:frost_land_tree"},
	}
})

minetest.register_craft({
	output = "skywars:fence_frost_land_wood 4",
	recipe = {
		{"skywars:frost_land_wood", "default:stick", "skywars:frost_land_wood"},
		{"skywars:frost_land_wood", "default:stick", "skywars:frost_land_wood"},
		{"", "", ""},
	}
})

minetest.register_craft({
	output = "skywars:fence_rail_frost_land_wood 16",
	recipe = {
		{"skywars:frost_land_wood", "skywars:frost_land_wood", ""},
		{"", "", ""},
		{"skywars:frost_land_wood", "skywars:frost_land_wood", ""},
	}
})
