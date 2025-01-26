minetest.register_chatcommand("building_help", {
    description = "Displays the building guide for J&C Skywars",
    func = function(name)
        minetest.show_formspec(name, "building_help", 
            "formspec_version[6]" ..
            "size[12,12]" ..
            "box[0,0;12.1,1;#000000]" ..
            "label[5.7,0.5;Help]" ..
            "label[0.3,1.6;Read the following guide on an idea for how you should aim to build the map]" ..
            "textarea[0,2.2;12,8.4;help;;" ..
            "Guide for building a map for J&C skywars. READ CAREFULLY\n\n" ..
            "How to build?\n" ..
            "First run the command \"/start\" to get your privs and setup the borders for building\n" ..
            "Please always start building from your spawnpoint (0,48,0).\n" ..
            "DONT BUILD UNDER Y = 0. ONLY VOID\n" ..
            "You cant build past the borders but don't break the glass please.\n\n" ..
            "How to scatter chests\n" ..
            "The loot on the main island for iron and mese chest should be in the ratio 3:1 (iron:mese).\n" ..
            "The loot on the outside island for iron and mese chests should be in the ratio 1:3 (iron:mese).\n" ..
            "If you don't understand then we can place the chest for you when we are reviewing the map.\n\n" ..
            "What we expect?\n" ..
            "We expect a main PVP island for players to PVP on\n" ..
            "We also expect tiny islands around the main island (this is where most of the mese chests should go)\n\n" ..
            "Please do not:\n" ..
            "Try to hide loot chests. The map will be investigated thoroughly\n" ..
            "Try to hide chests with loot in them. They will always get deleted anyways.\n\n" ..
            "What to do after you have finished building?\n" ..
            "Run the command \"/savemap\". You will be asked three questions. After you have answered the questions, your game will pause for around 30-60 seconds. " ..
            "After this time period, your map should have been sent for reviewing (as well as the questions you have answered). The map will also be saved in your local device.\n\n" ..
            "What will happen if your map gets approval?\n" ..
            "Your map will be put in the map rotations. You will receive credit for it each time it appears. You will also receive the map builder role in discord too.]" ..
            "button_exit[4.8,11;3,0.8;Close;Close]"
        )
    end,
})
