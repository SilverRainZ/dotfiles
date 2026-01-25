require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = false,
    hide_during_completion = true,
    debounce = 15,
    trigger_on_accept = true,
    keymap = {
      accept = "<C-CR>",
      accept_word = false,
      accept_line = false,
      next = "<C-left>",
      toggle_auto_trigger = false,
    },
  },
  panel = { enabled = false },
  -- debug = true,
})
