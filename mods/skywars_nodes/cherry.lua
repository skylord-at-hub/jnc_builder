local MP = core.get_modpath(core.get_current_modname())

-- Nodes
minetest.register_node(":skywars:cherry_leaves", {
    description = "Cherry Blossom Leaves",
    drawtype = "allfaces_optional",
    waving = 1,
    tiles = {"cherry_leaves.png"},
    paramtype = "light",
    is_ground_content = false,
    groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
    drop = {
        max_items = 1,
        items = {
            {items = {"skywars:cherry_sapling"}, rarity = 20},
            {items = {"skywars:cherry_leaves"}}
        }
    },
    sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node(":skywars:cherry_dirt_with_grass", {
    description = "Cherry Blossom Grass",
    tiles = {"cherry_grass.png", "default_dirt.png",
        {name = "default_dirt.png^cherry_grass_side.png",
            tileable_vertical = false}},
    groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
    drop = "default:dirt",
    sounds = default.node_sound_dirt_defaults({
        footstep = {name = "default_dirt_footstep", gain = 0.25},
    }),
})

minetest.register_node(":skywars:cherry_tree", {
    description = "Cherry Blossom Tree",
    tiles = {"cherry_tree_top.png", "cherry_tree_top.png",
        "cherry_tree.png"},
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
    sounds = default.node_sound_wood_defaults(),

    on_place = minetest.rotate_node
})

minetest.register_node(":skywars:cherry_wood", {
    description = "Cherry Blossom Wood",
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {"cherry_wood.png"},
    is_ground_content = false,
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
    sounds = default.node_sound_wood_defaults(),
})

minetest.register_node(":skywars:cherry_leaves_on_the_ground", {
    description = "Cherry Blossom Leaves on the ground",
    drawtype = "signlike",
    waving = 1,
    tiles = {"cherry_petals.png"},
    inventory_image = "cherry_petals.png",
    wield_image = "cherry_petals.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    buildable_to = true,
    groups = {snappy = 3, attached_node = 1, oddly_breakable_by_hand=3, flammable = 1},
    sounds = default.node_sound_leaves_defaults(),
    selection_box = {
        type="wallmounted",
        wall_top = {-0.5, 0.49, -0.5, 0.5, 0.5, 0.5},
        wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
        wall_side = {-0.5, -0.5, -0.5, -0.49, 0.5, 0.5},
    },
})
    default.register_leafdecay({
        trunks = {"skywars:cherry_tree"},
        leaves = {"skywars:cherry_leaves"},
        radius = 3,
    })


    stairs.register_stair_and_slab("cherry_wood", "skywars:cherry_wood",
        {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
        {"cherry_wood.png"},
        "cherry Wood Stair",
        "cherry Wood Slab",
        default.node_sound_wood_defaults())


doors.register_fencegate("skywars:gate_cherry", {
    description = "Cherry Blossom Wood Fence Gate",
    texture = "cherry_wood_fence.png",
    material = "skywars:cherry_wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

    default.register_fence(":skywars:fence_cherry_wood", {
        description = "Cherry Blossom Wood Fence",
        texture = "cherry_wood_fence.png",
        inventory_image = "default_fence_overlay.png^cherry_wood_fence.png^" ..
                    "default_fence_overlay.png^[makealpha:255,126,126",
        wield_image = "default_fence_overlay.png^cherry_wood_fence.png^" ..
                    "default_fence_overlay.png^[makealpha:255,126,126",
        material = "skywars:cherry_wood",
        groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
        sounds = default.node_sound_wood_defaults()
    })

    default.register_fence_rail(":skywars:fence_rail_cherry_wood", {
        description = "Cherry Blossom Wood Fence Rail",
        texture = "cherry_wood_fence.png",
        inventory_image = "default_fence_rail_overlay.png^cherry_wood_fence.png^" ..
                    "default_fence_rail_overlay.png^[makealpha:255,126,126",
        wield_image = "default_fence_rail_overlay.png^cherry_wood_fence.png^" ..
                    "default_fence_rail_overlay.png^[makealpha:255,126,126",
        material = "skywars:cherry_wood",
        groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
        sounds = default.node_sound_wood_defaults()
    })


    -- Sapling
local schematic_offsets = {
	["cherry_blossom_tree_1.mts"] = {x = -2, y = 0, z = -2},
	["cherry_blossom_tree_2.mts"] = {x = - 2, y = 0, z = -2},
	["cherry_blossom_tree_3.mts"] = {x = - 3, y = 0, z = -3},
}

local function grow_new_cherry_blossom_tree(pos)
	if not default.can_grow(pos) then
		minetest.get_node_timer(pos):start(math.random(300, 1500))
		return
	end

	minetest.remove_node(pos)
	local random_tree = "cherry_blossom_tree_" .. math.random(1, 3) .. ".mts"
	local offset = schematic_offsets[random_tree]
	minetest.place_schematic(
		{x = pos.x + offset.x, y = pos.y + offset.y, z = pos.z + offset.z},
		MP .. "/schems/" .. random_tree,
		"0",
		nil,
		false
	)
end

minetest.register_node(":skywars:cherry_blosson_sapling", {
	description = "Cherry Blosson Sapling",
	drawtype = "plantlike",
	tiles = {"cherry_trees.png"},
	inventory_image = "cherry_trees.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_cherry_blossom_tree,
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
			"skywars:cherry_blosson_sapling",
			{x = -1, y = 0, z = -1},
			{x = 1, y = 3, z = 1},
			2 
		)

		return itemstack
	end,
})

if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"skywars:cherry_blosson_sapling", grow_new_cherry_blossom_tree, "soil"},
	})
end

default.register_leafdecay({
	trunks = {"skywars:cherry_tree"},
	leaves = {"skywars:cherry_leaves"},
	radius = 3,
})

-- Crafting

minetest.register_craft({
	output = "skywars:fence_rail_cherry_wood 16",
	recipe = {
		{"skywars:cherry_wood", "skywars:cherry_wood", ""},
		{"", "", ""},
		{"skywars:cherry_wood", "skywars:cherry_wood", ""},
	}
})

minetest.register_craft({
	output = "skywars:cherry_wood 4",
	recipe = {
		{"skywars:cherry_tree"}
	}
})

minetest.register_craft({
	output = "skywars:fence_cherry_wood",
	recipe = {
		{"", "", ""},
		{"", "", ""},
		{"", "", ""},
	}
})


minetest.register_craft({
	output = "skywars:fence_cherry_wood",
	recipe = {
		{"skywars:cherry_wood", "default:stick", "skywars:cherry_wood"},
		{"skywars:cherry_wood", "default:stick", "skywars:cherry_wood"},
		{"", "", ""},
	}
})
