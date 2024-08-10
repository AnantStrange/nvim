return{
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    -- enabled = false,
    config = function()
       require("gitsigns").setup()
    end,
}
