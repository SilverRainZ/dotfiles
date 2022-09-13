-- https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts
-- brew tap homebrew/cask-fonts
-- brew install --cask font-iosevka-nerd-font
vim.opt.termguicolors = true

require("bufferline").setup{
    options = {
        -- https://github.com/akinsho/bufferline.nvim/issues/386
        -- separator_style = "slant",
    }
}
