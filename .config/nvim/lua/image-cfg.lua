require("image").setup({
  backend = "kitty", -- or "ueberzug" or "sixel"
  processor = "magick_cli", -- or "magick_rock"

  max_width = 256,

  integrations = {
    rst = {
      enabled = true,
      clear_in_insert_mode = true,
      download_remote_images = false,
      only_render_image_at_cursor = true,
      only_render_image_at_cursor_mode = "popup", -- or "inline"
      floating_windows = true, -- if true, images will be rendered in floating markdown windows

      resolve_image_path = function(document_path, image_path, fallback)
        if not vim.startswith(image_path, "/_images/") then
          return fallback(document_path, image_path)
        end
        local gitdir = vim.fn.finddir(".git", ".;")
        local gitroot = vim.fn.fnamemodify(gitdir, ":h")
        return gitroot .. image_path
      end,
    },
  }
})
