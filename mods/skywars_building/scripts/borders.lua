local S = minetest.get_translator(minetest.get_current_modname())
local SPAWN_BLOCK_POS = {x = 0, y = 50, z = 0}
local BORDER_POS1 = {x = -163.0, y = 30.0, z = -311.0}
local BORDER_POS2 = {x = 300.0, y = 600.0, z = 326.0}
local MP = core.get_modpath(core.get_current_modname())

minetest.set_mapgen_params({mgname = "singlenode"}) -- Void

local function is_within_borders(pos)
    return pos.x >= BORDER_POS1.x and pos.x <= BORDER_POS2.x
       and pos.y >= BORDER_POS1.y and pos.y <= BORDER_POS2.y
       and pos.z >= BORDER_POS1.z and pos.z <= BORDER_POS2.z
end


-- Handle player spawning
minetest.register_on_newplayer(function(player)
    player:set_pos(SPAWN_BLOCK_POS)
end)

-- Place a stone to stop player from falling into the void
minetest.register_on_generated(function(minp, maxp, seed)
    if minp.x <= 0 and maxp.x >= 0 and minp.y <= 48 and maxp.y >= 48 and minp.z <= 0 and maxp.z >= 0 then
        minetest.set_node({x=0, y=48, z=0}, {name="default:stone"})
    end
end)

-- Stop player from building outside the border
minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    if not is_within_borders(pos) then
        minetest.chat_send_player(placer:get_player_name(), S("You cannot place blocks outside the world borders."))
        if placer and placer:is_player() then
            local inv = placer:get_inventory()
            if inv then
                inv:add_item("main", ItemStack(newnode.name))
            end
        end
        minetest.remove_node(pos)
        return true
    end
end)

-- Place the world borders (basically modified code of cows resetmap)
core.register_chatcommand("start", {
	func = function(name, params)
		local filename = "mapbase.mts"

		core.place_schematic(BORDER_POS1, MP .. "/schems/" .. filename, 0, {}, true)

		local privs_to_grant = {
			interact = true,
            shout = true,
            ban = true,
            kick = true,
            fast = true,
            noclip = true,
            teleport = true,
            privs = true,
            home = true,
            fly = true,
            server = true,
            creative = true,
		}
		
		local current_privs = core.get_player_privs(name)
		for priv, value in pairs(privs_to_grant) do
			current_privs[priv] = value
		end
		core.set_player_privs(name, current_privs)
		core.chat_send_player(name, "Map has been formatted and you are free to start building! Type the command `/building_help` for help.")
	end,
})