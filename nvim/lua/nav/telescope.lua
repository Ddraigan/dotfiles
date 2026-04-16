return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "sharkdp/fd",
    "wesleimp/telescope-windowizer.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  config = function()
    local actions = require("telescope.actions")
    local opts = {
      defaults = {
        mappings = {
          i = { ["<c-t>"] = require("trouble.sources.telescope").open },
          n = { ["<c-t>"] = require("trouble.sources.telescope").open },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        layout_config = {
          horizontal = {
            preview_width = 0.5,
            results_width = 0.8,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 50,
        },
        file_ignore_patterns = { "node_modules" },
        preview = {
          mime_hook = function(filepath, bufnr, opts)
            local is_image = function(filepath)
              local image_extensions = { "png", "jpg" } -- Supported image formats
              local split_path = vim.split(filepath:lower(), ".", { plain = true })
              local extension = split_path[#split_path]
              return vim.tbl_contains(image_extensions, extension)
            end
            if is_image(filepath) then
              local term = vim.api.nvim_open_term(bufnr, {})
              local function send_output(_, data, _)
                for _, d in ipairs(data) do
                  vim.api.nvim_chan_send(term, d .. "\r\n")
                end
              end
              vim.fn.jobstart({
                "catimg",
                filepath, -- Terminal image viewer command
              }, { on_stdout = send_output, stdout_buffered = true, pty = true })
            else
              require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
            end
          end,
        },
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
        lsp_references = {
          path_display = { "truncate" },
        },
      },
      extensions = {
        windowizer = {
          find_cmd = "fd", -- find command. Available options [ find | fd | rg ] (defaults to "fd")
        },
        extensions = function()
          if vim.fn.has("win32") == 1 then
            return {}
          else
            return {
              fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
              },
            }
          end
        end,
      },
    }

    -- Wrap text on help files. looks awful tho :(
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "TelescopePreviewerLoaded",
    --   callback = function(args)
    --     if args.data.filetype ~= "help" then
    --       vim.wo.number = true
    --     elseif args.data.bufname:match("*.csv") then
    --       vim.wo.wrap = false
    --     end
    --   end,
    -- })

    require("telescope").setup(opts)
    require("telescope").load_extension("windowizer")
    if not vim.fn.has("win32") == 1 then
      require("telescope").load_extension("fzf")
    end

    -- require("telescope").load_extension("harpoon")
  end,
}
