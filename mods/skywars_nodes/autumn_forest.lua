local MP = core.get_modpath(core.get_current_modname())

-- Nodes
minetest.register_node(":skywars:autumn_forest_grass", {
	description = "Autumn Forest Grass",
	tiles = {"autumn_forest_grass.png", "default_dirt.png",
		{name = "default_dirt.png^autumn_forest_grass_side.png",
			tileable_vertical = false}},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node(":skywars:autumn_forest_leaves", {
	description = "Yellow Autumn Forest Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"autumn_forest_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"skywars:autumn_forest_sapling"}, rarity = 20},
			{items = {"skywars:autumn_forest_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

})

minetest.register_node(":skywars:autumn_forest_leaves_2", {
	description = "Orange Autumn Forest Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"autumn_forest_leaves_2.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"skywars:autumn_forest_sapling"}, rarity = 20},
			{items = {"skywars:autumn_forest_leaves_2"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

})

minetest.register_node(":skywars:autumn_forest_leaves_3", {
	description = "Red Autumn Forest Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"autumn_forest_leaves_3.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"skywars:autumn_forest_sapling"}, rarity = 20},
			{items = {"skywars:autumn_forest_leaves_3"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

})

minetest.register_node(":skywars:autumn_forest_tree", {
	description = "Autumn Forest Tree",
	tiles = {"autumn_forest_tree_top.png", "autumn_forest_tree_top.png",
		"autumn_forest_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})


minetest.register_node(":skywars:autumn_forest_wood", {
	description = "Autumn Forest Wood",
	tiles = {"autumn_forest_wood.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

doors.register_fencegate("skywars:gate_autumn_forest", {
	description = "Autumn Forest Wood Fence Gate",
	texture = "autumn_forest_wood_fence.png",
	material = "skywars:autumn_forest_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

	default.register_fence(":skywars:fence_autumn_forest_wood", {
		description = "Autumn Forest Wood Fence",
		texture = "autumn_forest_wood_fence.png",
		inventory_image = "default_fence_overlay.png^autumn_forest_wood_fence.png^" ..
					"default_fence_overlay.png^[makealpha:255,126,126",
		wield_image = "default_fence_overlay.png^autumn_forest_wood_fence.png^" ..
					"default_fence_overlay.png^[makealpha:255,126,126",
		material = "skywars:autumn_forest_wood",
		groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
		sounds = default.node_sound_wood_defaults()
	})

	default.register_fence_rail(":skywars:fence_rail_autumn_forest_wood", {
		description = "Autumn Forest Wood Fence Rail",
		texture = "autumn_forest_wood_fence.png",
		inventory_image = "default_fence_rail_overlay.png^autumn_forest_wood_fence.png^" ..
					"default_fence_rail_overlay.png^[makealpha:255,126,126",
		wield_image = "default_fence_rail_overlay.png^autumn_forest_wood_fence.png^" ..
					"default_fence_rail_overlay.png^[makealpha:255,126,126",
		material = "skywars:autumn_forest_wood",
		groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
		sounds = default.node_sound_wood_defaults()
	})

	minetest.register_node(":skywars:autumn_forest_grass_1", {
		description = "Autumn Forest Grass",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"autumn_forest_grass_1.png"},
		inventory_image = "autumn_forest_grass_3.png",
		wield_image = "autumn_forest_grass_3.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1},
		max_items = 1,
			items = {
				{items = {"farming:seed_wheat"}, rarity = 5},
				{items = {"skywars:autumn_forest_grass_1"}},
			},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
		},

		on_place = function(itemstack, placer, pointed_thing)
			-- place a random grass node
			local stack = ItemStack("skywars:autumn_forest_grass_" .. math.random(1,5))
			local ret = minetest.item_place(stack, placer, pointed_thing)
			return ItemStack("skywars:autumn_forest_grass_1 " ..
				itemstack:get_count() - (1 - ret:get_count()))
		end,
	})

for i = 2, 5 do
	minetest.register_node(":skywars:autumn_forest_grass_" .. i, {
		description = "Autumn Forest Grass",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"autumn_forest_grass_" .. i .. ".png"},
		inventory_image = "autumn_forest_grass_" .. i .. ".png",
		wield_image = "autumn_forest_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop = "skywars:autumn_forest_grass_1",
		groups = {snappy = 3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1, flammable = 1},
			max_items = 1,
		items = {
			{items = {"farming:seed_wheat"}, rarity = 5},
			{items = {"skywars:autumn_forest_grass_1"}},
		},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
		},
	})
end

minetest.register_node(":skywars:pumpkin_block", {
	description = "Pumpkin",
	tiles = {"autumn_forest_pumpkin_fruit_top.png", "autumn_forest_pumpkin_fruit_top.png", "autumn_forest_pumpkin_fruit_side.png", "autumn_forest_pumpkin_fruit_side.png", "autumn_forest_pumpkin_fruit_side.png", "autumn_forest_pumpkin_fruit_side_off.png"},
	paramtype2 = "facedir",
	sounds = default.node_sound_wood_defaults(),
	is_ground_content = false,
	groups = {snappy=3, flammable=4, fall_damage_add_percent=-30},
})

minetest.register_node(":skywars:pumpkin_lantern", {
	description = "Pumpkin Lantern",
	tiles = {"autumn_forest_pumpkin_fruit_top.png", "autumn_forest_pumpkin_fruit_top.png", "autumn_forest_pumpkin_fruit_side.png", "autumn_forest_pumpkin_fruit_side.png", "autumn_forest_pumpkin_fruit_side.png", "autumn_forest_pumpkin_fruit_side_on.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = default.node_sound_wood_defaults(),
	is_ground_content = false,
	light_source = 12,
	drop = "skywars:pumpkin_lantern",
	groups = {snappy=3, flammable=4, fall_damage_add_percent=-30},
})

-- Saplings

local schematic_offsets = {
    ["autumn_forest_tree_1.mts"] = {x = -2, y = 0, z = -2},
    ["autumn_forest_tree_2.mts"] = {x = - 3, y = 0, z = -4}
}

local function grow_new_autumn_forest_tree(pos)
    if not default.can_grow(pos) then
        minetest.get_node_timer(pos):start(math.random(300, 1500))
        return
    end

    minetest.remove_node(pos)
    local random_tree = "autumn_forest_tree_" .. math.random(1, 2) .. ".mts"
    local offset = schematic_offsets[random_tree]
    minetest.place_schematic(
        {x = pos.x + offset.x, y = pos.y + offset.y, z = pos.z + offset.z},
        MP .. "/schems/" .. random_tree,
        "0",
        nil,
        false
    )
end

minetest.register_node(":skywars:autumn_forest_sapling", {
	description = "Autumn Forest Sapling",
	drawtype = "plantlike",
	tiles = {"autumn_forest_sapling.png"},
	inventory_image = "autumn_forest_sapling.png",
	wield_image = "autumn_forest_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_autumn_forest_tree,
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
			"skywars:autumn_forest_sapling",
			{x = -1, y = 0, z = -1},
			{x = 1, y = 3, z = 1},
			2 
		)

		return itemstack
	end,
})

if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"skywars:autumn_forest_sapling", grow_new_autumn_forest_tree, "soil"},
	})
end
	default.register_leafdecay({
		trunks = {"skywars:autumn_forest_tree"},
		leaves = {"skywars:autumn_forest_leaves", "skywars:autumn_forest_leaves_3", "skywars:autumn_forest_leaves_2"},
		radius = 3,
	})

-- Crafts

minetest.register_craft({
	output = "skywars:autumn_forest_wood 4",
	recipe = {
		{"skywars:autumn_forest_tree"},
	}
})

minetest.register_craft({
	output = "skywars:fence_autumn_forest_wood 4",
	recipe = {
		{"skywars:autumn_forest_wood", "default:stick", "skywars:autumn_forest_wood"},
		{"skywars:autumn_forest_wood", "default:stick", "skywars:autumn_forest_wood"},
		{"", "", ""},
	}
})

minetest.register_craft({
	output = "skywars:fence_rail_autumn_forest_wood 16",
	recipe = {
		{"skywars:autumn_forest_wood", "skywars:autumn_forest_wood", ""},
		{"", "", ""},
		{"skywars:autumn_forest_wood", "skywars:autumn_forest_wood", ""},
	}
})

minetest.register_craft({
	output = "skywars:pumpkin_lantern",
	recipe = {
		{"", "", ""},
		{"", "default:torch", ""},
		{"", "skywars:pumpkin_block", ""},
	}
})


-- MOREBLOCKS


if minetest.get_modpath("moreblocks") then

	stairsplus:register_all("autumn_forest_wood", "wood", "skywars:autumn_forest_wood", {
		description = "Frost Land Wood",
		tiles = {"autumn_forest_wood.png"},
      	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	    sounds = default.node_sound_wood_defaults(),
	})

	stairsplus:register_all("autumn_forest_tree", "tree", "skywars:autumn_forest_tree", {
		description = "Japanese Tree",
	tiles = {"autumn_forest_tree_top.png", "autumn_forest_tree_top.png",
		"autumn_forest_tree.png"},
      	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	    sounds = default.node_sound_wood_defaults(),
	})
end

stairs.register_stair_and_slab("autumn_forest_wood", "skywars:autumn_forest_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	{"autumn_forest_wood.png"},
	"Autumn Forest Wood Stair",
	"Autumn Forest Wood Slab",
	default.node_sound_wood_defaults())
