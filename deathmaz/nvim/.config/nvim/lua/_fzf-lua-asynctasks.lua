local ok, fzf_lua_asynctasks = pcall(require, 'fzf-lua-asynctasks')
if not ok then
  return
end
fzf_lua_asynctasks.setup()
