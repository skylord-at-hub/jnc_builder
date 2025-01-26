local MP = core.get_modpath(core.get_current_modname())
local mod_name = minetest.get_current_modname()
local BORDER_POS1 = {x = -163.0, y = 30.0, z = -311.0}
local BORDER_POS2 = {x = 300.0, y = 600.0, z = 326.0}
local http = minetest.request_http_api()

minetest.set_mapgen_params({mgname = "singlenode"}) -- void

core.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    core.chat_send_player(name, "Welcome. Please run the command `/start` to get started! If you have already started to build on the world then don't run `start` and continue from where you have left.")
end)

if not minetest.settings:get("secure.http_mods") or 
   not string.find(minetest.settings:get("secure.http_mods"), mod_name) then
    error("ERROR: Please add \"" .. mod_name .. "\" to secure.http_mods in your Minetest settings to load this world.")
end

dofile(MP .. "/scripts/borders.lua")
dofile(MP .. "/scripts/formspecs_info.lua")

-- Send map to devs to review
local function send_to_discord_webhook(filepath, filename, creators, discord_user, description)
    local webhook_url = "https://discord.com/api/webhooks/1326515050734944369/k1ERvVm3lGwmmbhEFSZxFEYbc2vVHnRI2x26Nn-SdvVNitW8HTeONRLcdE3xEYs-5D6a" -- Don't abuse this.
    local file = io.open(filepath, "rb")
    if not file then
        minetest.log("error", "Failed to open file: " .. filepath)
        return
    end
    local file_content = file:read("*all")
    file:close()

    local boundary = "------------------------" .. os.time()
    local body = ""
        .. "--" .. boundary .. "\r\n"
        .. 'Content-Disposition: form-data; name="file"; filename="' .. filename .. '"\r\n'
        .. "Content-Type: application/octet-stream\r\n\r\n"
        .. file_content .. "\r\n"
        .. "--" .. boundary .. "\r\n"
        .. 'Content-Disposition: form-data; name="payload_json"\r\n'
        .. "Content-Type: application/json\r\n\r\n"
        .. minetest.write_json({
            content = "New map uploaded by " .. creators,
            embeds = {{
                title = filename,
                fields = {
                    {name = "Creators", value = creators},
                    {name = "Discord User/email", value = discord_user},
                    {name = "Description", value = description or "No description provided."}
                }
            }}
        }) .. "\r\n"
        .. "--" .. boundary .. "--\r\n"

    http.fetch({
        url = webhook_url,
        method = "POST",
        extra_headers = {
            "Content-Type: multipart/form-data; boundary=" .. boundary
        },
        data = body,
    }, function(res)
        if res.succeeded then
            minetest.log("action", "Map sent for inspection successfully")
        else
            minetest.log("error", "Failed to send map for inspection: " .. (res.error or "Unknown error"))
        end
    end)
end

local save_map_state = {}

-- To save map
minetest.register_chatcommand("savemap", {
    description = "Sends the map for inspection and saves the map to your local device",
    func = function(name, param)
        save_map_state[name] = {step = 1}
        minetest.chat_send_player(name, "What do you want the map name to be?") -- Starts questioning
        return true
    end,
})

minetest.register_on_chat_message(function(name, message)
    local state = save_map_state[name]
    if not state then return end

    if state.step == 1 then
        state.map_name = message
        state.step = 2
        minetest.chat_send_player(name, "Who are the creators of this map?")
    elseif state.step == 2 then
        state.creators = message
        state.step = 3
        minetest.chat_send_player(name, "What is your Discord username or email? (This is to contact you)")
    elseif state.step == 3 then
        state.discord_user = message
        state.step = 4
        minetest.chat_send_player(name, "Do you want to add a description? (Type 'skip' to skip)")
    elseif state.step == 4 then
        state.description = message ~= "skip" and message or nil

        local filename = state.map_name .. ".mts"
        local schems_path = minetest.get_worldpath() .. "/schems"
        local filepath = schems_path .. "/" .. filename
        minetest.mkdir(schems_path)

        if minetest.create_schematic(BORDER_POS1, BORDER_POS2, nil, filepath, nil) then
            minetest.log("action", "Schematic saved successfully to " .. filepath)           
            send_to_discord_webhook(filepath, filename, state.creators, state.discord_user, state.description)
            minetest.chat_send_player(name, minetest.colorize("#00FF00", "Map saved as " .. filename .. ". The map has been sent for reviewing. Thank you for your time."))
        else
            minetest.log("error", "Failed to save schematic to " .. filepath)
            minetest.chat_send_player(name, minetest.colorize("#FF0000", "Failed to save the map. Check debug.txt for details."))
        end

        save_map_state[name] = nil
    end

    return true
end)