local util = require 'lspconfig.util'

return {
  root_dir = function(fname)
      return util.root_pattern(
        'tailwind.config.ts',
        'tailwind.config.js',
        'tailwind.config.cjs',
        'tailwind.config.mjs',
        'postcss.config.js',
        'postcss.config.cjs',
        'postcss.config.mjs',
        'postcss.config.ts'
      )(fname) or util.find_package_json_ancestor(fname) or util.find_node_modules_ancestor(fname) or util.find_git_ancestor(
        fname
      )
    end,
}
