return{
    "terrortylor/nvim-comment", --auto comment <leader>c 
    config = function ()
        require('nvim_comment').setup({comment_empty = false})
    end

}
