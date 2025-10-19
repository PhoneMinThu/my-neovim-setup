-- lua/plugins/devicons.lua
return {
    {
        "nvim-tree/nvim-web-devicons",
        opts = {
            default = true,
            override_by_extension = {
                vue  = { icon = "󰡄", color = "#8bd5ca", name = "Vue" },
                ts   = { icon = "", color = "#519aba", name = "TypeScript" },
                tsx  = { icon = "", color = "#519aba", name = "TSX" },
                json = { icon = "", color = "#cbcb41", name = "Json" },
            },
        },
    },
}
