return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "doom",
      config = {
        header = {
          "                                                                       ",
          "                                                                       ",
          "                                                                       ",
          "  ██████   █████                   █████   █████  ███                  ",
          " ░░██████ ░░███                   ░░███   ░░███  ░░░                   ",
          "  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ",
          "  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ",
          "  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ",
          "  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ",
          "  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ",
          " ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ",
          "                                                                       ",
          "                                                                       ",
          "                                                                       ",
        },
        center = {
          {
            action = LazyVim.telescope("files"),
            desc = " Find File",
            icon = " ",
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = " New File",
            icon = " ",
            key = "n",
          },
          {
            action = "Telescope oldfiles",
            desc = " Recent Files",
            icon = " ",
            key = "r",
          },
          {
            action = "Telescope live_grep",
            desc = " Find Text",
            icon = " ",
            key = "g",
          },
          { action = [[lua LazyVim.telescope.config_files()()]], desc = " Config", icon = " ", key = "c" },
          {
            action = 'lua require("persistence").load()',
            desc = " Restore Session",
            icon = " ",
            key = "s",
          },
          {
            action = "qa",
            desc = " Quit",
            icon = " ",
            key = "q",
          },
        },
        footer = function()
          return { "A craftsman must sharpen his tools to do his job" }
        end,
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
