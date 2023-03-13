nvim.lsp = {}
local tbl_contains = vim.tbl_contains
local tbl_isempty = vim.tbl_isempty
local conditional_func = nvim.conditional_func
local is_available = nvim.is_available
local user_plugin_opts = nvim.user_plugin_opts

nvim.lsp.formatting = { format_on_save = { enabled = true }, disabled = {} }
if type(nvim.lsp.formatting.format_on_save) == "boolean" then
    nvim.lsp.formatting.format_on_save = { enabled = nvim.lsp.formatting.format_on_save }
end

nvim.lsp.format_opts = vim.deepcopy(nvim.lsp.formatting)
nvim.lsp.format_opts.disabled = nil
nvim.lsp.format_opts.format_on_save = nil
nvim.lsp.format_opts.filter = function(client)
    local filter = nvim.lsp.formatting.filter
    local disabled = nvim.lsp.formatting.disabled or {}
    -- check if client is fully disabled or filtered by function
    return not (vim.tbl_contains(disabled, client.name) or (type(filter) == "function" and not filter(client)))
end

--- Helper function to set up a given server with the Neovim LSP client
-- @param server the name of the server to be setup
nvim.lsp.setup = function(server)
    if not tbl_contains({}, server) then
        local opts = nvim.lsp.server_settings(server)
        require("lspconfig")[server].setup(opts)
    end
end

--- The `on_attach` function used by nvim
-- @param client the LSP client details when attaching
-- @param bufnr the number of the buffer that the LSP client is attaching to
nvim.lsp.on_attach = function(client, bufnr)
    local capabilities = client.server_capabilities
    local lsp_mappings = {
        n = {
                ["<leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
                ["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
                ["]d"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
                ["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        },
        v = {},
    }

    if is_available "mason-lspconfig.nvim" then
        lsp_mappings.n["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" }
    end

    if is_available "null-ls.nvim" then
        lsp_mappings.n["<leader>lI"] = { "<cmd>NullLsInfo<cr>", desc = "Null-ls information" }
    end

    if capabilities.codeActionProvider then
        lsp_mappings.n["<leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" }
        lsp_mappings.v["<leader>la"] = lsp_mappings.n["<leader>la"]
    end

    if capabilities.codeLensProvider then
        lsp_mappings.n["<leader>ll"] = { function() vim.lsp.codelens.refresh() end, desc = "LSP codelens refresh" }
        lsp_mappings.n["<leader>lL"] = { function() vim.lsp.codelens.run() end, desc = "LSP codelens run" }
    end

    if capabilities.declarationProvider then
        lsp_mappings.n["gD"] = { function() vim.lsp.buf.declaration() end, desc = "Declaration of current symbol" }
    end

    if capabilities.definitionProvider then
        lsp_mappings.n["gd"] = { function() vim.lsp.buf.definition() end, desc = "Show the definition of current symbol" }
    end

    if capabilities.documentFormattingProvider and not tbl_contains(nvim.lsp.formatting.disabled, client.name) then
        lsp_mappings.n["<leader>lf"] = {
            function() vim.lsp.buf.format(nvim.lsp.format_opts) end,
            desc = "Format buffer",
        }
        lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]

        vim.api.nvim_buf_create_user_command(
            bufnr,
            "Format",
            function() vim.lsp.buf.format(nvim.lsp.format_opts) end,
            { desc = "Format file with LSP" }
        )
        local autoformat = nvim.lsp.formatting.format_on_save
        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
        if
            autoformat.enabled
            and (tbl_isempty(autoformat.allow_filetypes or {}) or tbl_contains(autoformat.allow_filetypes, filetype))
            and (tbl_isempty(autoformat.ignore_filetypes or {}) or not tbl_contains(autoformat.ignore_filetypes, filetype))
        then
            local autocmd_group = "auto_format_" .. bufnr
            vim.api.nvim_create_augroup(autocmd_group, { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = autocmd_group,
                buffer = bufnr,
                desc = "Auto format buffer " .. bufnr .. " before save",
                callback = function()
                    if vim.g.autoformat_enabled then
                        vim.lsp.buf.format(nvim.default_tbl({ bufnr = bufnr }, nvim.lsp.format_opts))
                    end
                end,
            })
            lsp_mappings.n["<leader>uf"] = {
                function() nvim.ui.toggle_autoformat() end,
                desc = "Toggle autoformatting",
            }
        end
    end

    if capabilities.documentHighlightProvider then
        local highlight_name = vim.fn.printf("lsp_document_highlight_%d", bufnr)
        vim.api.nvim_create_augroup(highlight_name, {})
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = highlight_name,
            buffer = bufnr,
            callback = function() vim.lsp.buf.document_highlight() end,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = highlight_name,
            buffer = bufnr,
            callback = function() vim.lsp.buf.clear_references() end,
        })
    end

    if capabilities.hoverProvider then
        lsp_mappings.n["K"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" }
    end

    if capabilities.implementationProvider then
        lsp_mappings.n["gI"] = { function() vim.lsp.buf.implementation() end, desc = "Implementation of current symbol" }
    end

    if capabilities.referencesProvider then
        lsp_mappings.n["gr"] = { function() vim.lsp.buf.references() end, desc = "References of current symbol" }
        lsp_mappings.n["<leader>lR"] = { function() vim.lsp.buf.references() end, desc = "Search references" }
    end

    if capabilities.renameProvider then
        lsp_mappings.n["<leader>lr"] = { function() vim.lsp.buf.rename() end, desc = "Rename current symbol" }
    end

    if capabilities.signatureHelpProvider then
        lsp_mappings.n["<leader>lh"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" }
    end

    if capabilities.typeDefinitionProvider then
        lsp_mappings.n["gT"] = { function() vim.lsp.buf.type_definition() end, desc = "Definition of current type" }
    end

    if capabilities.workspaceSymbolProvider then
        lsp_mappings.n["<leader>lG"] = { function() vim.lsp.buf.workspace_symbol() end, desc = "Search workspace symbols" }
    end

    if is_available "telescope.nvim" then -- setup telescope mappings if available
        if lsp_mappings.n.gd then lsp_mappings.n.gd[1] = function() require("telescope.builtin").lsp_definitions() end end
        if lsp_mappings.n.gI then
            lsp_mappings.n.gI[1] = function() require("telescope.builtin").lsp_implementations() end
        end
        if lsp_mappings.n.gr then lsp_mappings.n.gr[1] = function() require("telescope.builtin").lsp_references() end end
        if lsp_mappings.n["<leader>lR"] then
            lsp_mappings.n["<leader>lR"][1] = function() require("telescope.builtin").lsp_references() end
        end
        if lsp_mappings.n.gT then
            lsp_mappings.n.gT[1] = function() require("telescope.builtin").lsp_type_definitions() end
        end
        if lsp_mappings.n["<leader>lG"] then
            lsp_mappings.n["<leader>lG"][1] = function() require("telescope.builtin").lsp_workspace_symbols() end
        end
    end

    nvim.set_mappings(lsp_mappings, { buffer = bufnr })
    if not vim.tbl_isempty(lsp_mappings.v) then
        nvim.which_key_register({ v = { ["<leader>"] = { l = { name = "LSP" } } } }, { buffer = bufnr })
    end
end

--- The default nvim LSP capabilities
nvim.lsp.capabilities = vim.lsp.protocol.make_client_capabilities()
nvim.lsp.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
nvim.lsp.capabilities.textDocument.completion.completionItem.snippetSupport = true
nvim.lsp.capabilities.textDocument.completion.completionItem.preselectSupport = true
nvim.lsp.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
nvim.lsp.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
nvim.lsp.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
nvim.lsp.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
nvim.lsp.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
nvim.lsp.capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
}

nvim.lsp.flags = {}

--- Get the server settings for a given language server to be provided to the server's `setup()` call
-- @param  server_name the name of the server
-- @return the table of LSP options used when setting up the given language server
function nvim.lsp.server_settings(server_name)
    local server = require("lspconfig")[server_name]

    local opts = user_plugin_opts("server-settings." .. server_name, {
        -- get server-settings
        capabilities = vim.tbl_deep_extend("force", nvim.lsp.capabilities, server.capabilities or {}),
        flags = vim.tbl_deep_extend("force", nvim.lsp.flags, server.flags or {}),
    }, true, "configs")

    local old_on_attach = server.on_attach
    local user_on_attach = opts.on_attach
    opts.on_attach = function(client, bufnr)
        conditional_func(old_on_attach, true, client, bufnr)
        nvim.lsp.on_attach(client, bufnr)
        conditional_func(user_on_attach, true, client, bufnr)
    end
    return opts
end

return nvim.lsp
