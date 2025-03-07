local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy_configuration = {
    change_detection = {
        notify = false,
    },
}

require("lazy").setup(
    {
        { import = "configs.plugins" },
        { import = "configs.plugins.lsp" },
    },
    lazy_configuration
)
