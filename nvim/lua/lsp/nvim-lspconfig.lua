return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim",                     config = true },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
    { "folke/neodev.nvim" },
  },
  config = function ()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("config.utils").capabilities()

    local installed_servers = mason_lspconfig.get_installed_servers()
    local unconfigured_servers = {}
    for _, server in ipairs(installed_servers) do
      if not string.find(server, "tsserver") and not string.find(server, "rust_analyzer") then
        table.insert(unconfigured_servers, server)
      end
    end

    for _, lsp in pairs(unconfigured_servers) do
      lspconfig[lsp].setup({
        capabilities = capabilities,
      })
    end

    -- lspconfig.astro.setup({
    -- 	capabilities = capabilities,
    -- 	--[[ init_options = {
    -- 		typescript = {
    -- 			-- needs to be installed in ~ by using `pnpm i typescript`. NOTE: do not use -g flag!
    -- 			serverPath = os.getenv("HOME") .. "/.npm-packages/lib/node_modules/typescript/lib/typescript.js",
    -- 		},
    -- 	}, ]]
    -- })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_init = function (client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
          return
        end

        client.config.settings = vim.tbl_deep_extend("force",
          client.config.settings, {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                },
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
              },
            },
          })

        client.notify("workspace/didChangeConfiguration",
          { settings = client.config.settings })
      end,
      settings = {
        diagnostics = {
          globals = { "use", "vim", "require", "merge" },
          disable = { 'missing-fields' },
        },
        hint = {
          enable = true,
          arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
          await = true,
          paramName = "Disable",  -- "All", "Literal", "Disable"
          paramType = false,
          semicolon = "Disable",  -- "All", "SameLine", "Disable"
          setType = true,
        },
        format = {
          enable = true,
        },
        completion = {
          callSnipet = "Replace",
        },
      },
    })

    -- configure emmet language server
    lspconfig.emmet_ls.setup({
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
        "svelte",
        "astro",
      },
    })

    -- Tailwind
    -- Support for tailwind auto completion
    -- install the tailwind server : "sudo npm install -g @tailwindcss/language-server"
    -- lspconfig.tailwindcss.setup({
    -- 	capabilities = capabilities,
    -- })
  end,
}

-- max_line_length = "120",
--
-- -- optional crlf/lf/cr/auto, if it is 'auto', in windows it is crlf other platforms are lf
-- -- in neovim the value 'auto' is not a valid option, please use 'unset'
-- end_of_line = "auto",
--
-- --  none/ comma / semicolon / only_kv_colon
-- table_separator_style = "none",
--
-- --optional keep/never/always/smart
-- trailing_table_separator = "keep",
--
-- -- keep/remove/remove_table_only/remove_string_only
-- call_arg_parentheses = "keep",
--
-- detect_end_of_line = false,
--
-- -- this will check text end with new line
-- insert_final_newline = true,
--
-- -- [space]
-- space_around_table_field_list = true,
--
-- space_before_attribute = true,
--
-- space_before_function_open_parenthesis = false,
--
-- space_before_function_call_open_parenthesis = false,
--
-- space_before_closure_open_parenthesis = true,
--
-- -- optional always/only_string/only_table/none
-- -- or true/false
-- space_before_function_call_single_arg = "always",
-- ---- extend option
-- ---- always/keep/none
-- -- space_before_function_call_single_arg.table = always
-- ---- always/keep/none
-- -- space_before_function_call_single_arg.string = always
--
-- space_before_open_square_bracket = false,
--
-- space_inside_function_call_parentheses = false,
--
-- space_inside_function_param_list_parentheses = false,
--
-- space_inside_square_brackets = false,
--
-- -- like t[#t+1] = 1
-- space_around_table_append_operator = false,
--
-- ignore_spaces_inside_function_call = false,
--
-- -- detail number or 'keep'
-- space_before_inline_comment = 1,
--
-- -- [operator space]
-- space_around_math_operator = true,
-- -- space_around_math_operator.exponent = false
--
-- space_after_comma = true,
--
-- space_after_comma_in_for_statement = true,
--
-- -- true/false or none/always/no_space_asym
-- space_around_concat_operator = true,
--
-- space_around_logical_operator = true,
--
-- -- true/false or none/always/no_space_asym
-- space_around_assign_operator = true,
--
-- -- [align]
--
-- align_call_args = false,
--
-- align_function_params = true,
--
-- align_continuous_assign_statement = true,
--
-- align_continuous_rect_table_field = true,
--
-- align_continuous_line_space = 2,
--
-- align_if_branch = false,
--
-- -- option none / always / contain_curly/
-- align_array_table = true,
--
-- align_continuous_similar_call_args = false,
--
-- align_continuous_inline_comment = true,
-- -- option none / always / only_call_stmt
-- align_chain_expr = "none",
--
-- -- [indent]
--
-- never_indent_before_if_condition = false,
--
-- never_indent_comment_on_if_branch = false,
--
-- keep_indents_on_empty_lines = false,
--
-- allow_non_indented_comments = false,
-- -- [line space]
--
-- -- The following configuration supports four expressions
-- -- keep
-- -- fixed(n)
-- -- min(n)
-- -- max(n)
-- -- for eg. min(2)
--
-- line_space_after_if_statement = "never",
--
-- line_space_after_do_statement = "keep",
--
-- line_space_after_while_statement = "keep",
--
-- line_space_after_repeat_statement = "keep",
--
-- line_space_after_for_statement = "keep",
--
-- line_space_after_local_or_assign_statement = "keep",
--
-- line_space_after_function_statement = "fixed(2)",
--
-- line_space_after_expression_statement = "keep",
--
-- line_space_after_comment = "keep",
--
-- line_space_around_block = "fixed(1)",
-- -- [line break]
-- break_all_list_when_line_exceed = false,
--
-- auto_collapse_lines = false,
--
-- break_before_braces = false,
--
-- -- [preference]
-- ignore_space_after_colon = false,
--
-- remove_call_expression_list_finish_comma = false,
-- -- keep / always / same_line / replace_with_newline / never
-- end_statement_with_semicolon = "keep",
