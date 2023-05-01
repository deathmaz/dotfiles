local ok, project = pcall(require, 'project_nvim')
if not ok then
  return
end
project.setup({
  detection_methods = {
    "pattern",
    "lsp",
  },
  exclude_dirs = {
    "node_modules",
    "build",
    "dist",
    "vendor",
  },
  patterns = {
    ".git",
    ".hg",
    ".bzr",
    ".svn",
    "Makefile",
    "package.json",
    "vite.config.js",
  },
})
