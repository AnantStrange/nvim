return {
    'mfussenegger/nvim-jdtls',
    -- paru -S jdtls  
    ft = { "java" },       -- Only start for Java files
    config = function()
        require("jdtls").start_or_attach({
            cmd = { '/usr/bin/jdtls' },
            root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
        })
    end
}
