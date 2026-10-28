-- Extra filetype detection, so the matching LSP / treesitter parser / formatter kicks in.
-- See `:help vim.filetype.add()`

-- Only treat a file as Helm when it sits inside a chart
local function in_chart(ft)
  return function(path) return vim.fs.root(path, 'Chart.yaml') and ft or nil end
end

vim.filetype.add {
  filename = {
    ['compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['docker-compose.yml'] = 'yaml.docker-compose',
  },
  pattern = {
    ['.*/templates/.*%.ya?ml'] = in_chart 'helm',
    ['.*/templates/.*%.tpl'] = in_chart 'helm',
    ['.*/values.*%.ya?ml'] = in_chart 'yaml.helm-values',
    ['docker%-compose%..*%.ya?ml'] = 'yaml.docker-compose',
  },
}

vim.treesitter.language.register('yaml', { 'yaml.docker-compose', 'yaml.helm-values' })
