if exists("current_compiler")
  finish
endif
let current_compiler = "yarn"

CompilerSet makeprg=yarn
