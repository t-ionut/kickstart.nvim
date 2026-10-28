-- lspconfig falls back to `.git` as root, which starts the server in every repo.
-- Only attach when there is a Tailwind/PostCSS config or a `tailwindcss` dependency (v4).
---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, function(name) return name:match '^tailwind%.config%.' ~= nil or name:match '^postcss%.config%.' ~= nil end)
    if root then return on_dir(root) end

    local pkg = vim.fs.find('package.json', { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)) })[1]
    if not pkg then return end
    local f = io.open(pkg)
    if not f then return end
    local content = f:read '*a'
    f:close()
    if content:find('"tailwindcss"', 1, true) then on_dir(vim.fs.dirname(pkg)) end
  end,
}
