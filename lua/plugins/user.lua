-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "gen740/SmoothCursor.nvim",
    config = function()
      -- local autocmd = vim.api.nvim_create_autocmd

      -- autocmd({ "ModeChanged" }, {
      --   callback = function()
      --     local current_mode = vim.fn.mode()
      --     if current_mode == "n" then
      --       vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#8aa872" })
      --       vim.fn.sign_define("smoothcursor", { text = "" })
      --     elseif current_mode == "v" then
      --       vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
      --       vim.fn.sign_define("smoothcursor", { text = "" })
      --     elseif current_mode == "V" then
      --       vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
      --       vim.fn.sign_define("smoothcursor", { text = "" })
      --     elseif current_mode == "�" then
      --       vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
      --       vim.fn.sign_define("smoothcursor", { text = "" })
      --     elseif current_mode == "i" then
      --       vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#668aab" })
      --       vim.fn.sign_define("smoothcursor", { text = "" })
      --     end
      --   end,
      -- })
      require("smoothcursor").setup {
        type = "matrix", -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".

        cursor = "*", -- Cursor shape (requires Nerd Font). Disabled in fancy mode.
        texthl = "SmoothCursor", -- Highlight group. Default is { bg = nil, fg = "#FFD400" }. Disabled in fancy mode.
        linehl = nil, -- Highlights the line under the cursor, similar to 'cursorline'. "CursorLine" is recommended. Disabled in fancy mode.

        fancy = {
          enable = true, -- enable fancy mode
          head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil }, -- false to disable fancy head
          body = {
            { cursor = "󰝥", texthl = "SmoothCursorRed" },
            { cursor = "󰝥", texthl = "SmoothCursorOrange" },
            { cursor = "●", texthl = "SmoothCursorYellow" },
            { cursor = "●", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = ".", texthl = "SmoothCursorBlue" },
            { cursor = ".", texthl = "SmoothCursorPurple" },
          },
          tail = { cursor = nil, texthl = "SmoothCursor" }, -- false to disable fancy tail
        },

        matrix = { -- Loaded when 'type' is set to "matrix"
          head = {
            -- Picks a random character from this list for the cursor text
            cursor = require "smoothcursor.matrix_chars",
            -- Picks a random highlight from this list for the cursor text
            texthl = {
              "SmoothCursor",
            },
            linehl = nil, -- No line highlight for the head
          },
          body = {
            length = 6, -- Specifies the length of the cursor body
            -- Picks a random character from this list for the cursor body text
            cursor = require "smoothcursor.matrix_chars",
            -- Picks a random highlight from this list for each segment of the cursor body
            texthl = {
              "SmoothCursorGreen",
            },
          },
          tail = {
            -- Picks a random character from this list for the cursor tail (if any)
            cursor = nil,
            -- Picks a random highlight from this list for the cursor tail
            texthl = {
              "SmoothCursor",
            },
          },
          unstop = false, -- Determines if the cursor should stop or not (false means it will stop)
        },

        autostart = true, -- Automatically start SmoothCursor
        always_redraw = true, -- Redraw the screen on each update
        flyin_effect = nil, -- Choose "bottom" or "top" for flying effect
        speed = 20, -- Max speed is 100 to stick with your current position
        intervals = 35, -- Update intervals in milliseconds
        priority = 10, -- Set marker priority
        timeout = 3000, -- Timeout for animations in milliseconds
        threshold = 3, -- Animate only if cursor moves more than this many lines
        max_threshold = nil, -- If you move more than this many lines, don't animate (if `nil`, deactivate check)
        disable_float_win = false, -- Disable in floating windows
        enabled_filetypes = nil, -- Enable only for specific file types, e.g., { "lua", "vim" }
        disabled_filetypes = nil, -- Disable for these file types, ignored if enabled_filetypes is set. e.g., { "TelescopePrompt", "NvimTree" }
        -- Show the position of the latest input mode positions.
        -- A value of "enter" means the position will be updated when entering the mode.
        -- A value of "leave" means the position will be updated when leaving the mode.
        -- `nil` = disabled
        show_last_positions = nil,
      }
    end,
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup {}
      require("telescope").load_extension "textcase"
    end,
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
    -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
    -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
    -- available after the first executing of it or after a keymap of text-case.nvim has been used.
    lazy = false,
  },
  {
    "TobinPalmer/rayso.nvim",
    config = function()
      require("rayso").setup {
        open_cmd = "chromium",
        options = {
          logging_path = "/Users/tobin/Documents/Rayso/", -- Notices the trailing slash
          logging_file = "rayso",
          logging_enabled = true,
          theme = "midnight",
        },
      }
      vim.keymap.set("v", "<leader>rs", require("lib.create").create_snippet)
    end,
  },
}
