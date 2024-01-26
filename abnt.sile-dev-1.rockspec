rockspec_format = "3.0"
package = "abnt.sile"
version = "dev-1"

description = {
  summary = "Automatiza a formatação de um trabalho conforme as normas da ABNT...",
  detailed = [[]],
  homepage = "https://github.com/jodros/abnt.sile",
  maintainer = "jodros",
  license = "MIT"
}

source = {
  url = "git+https://github.com/jodros/abnt.sile.git",
  -- tag = ""
}

dependencies = {}
build = {
  type = "builtin",

  modules = {
    ["sile.classes.abnt"] = "classes/abnt.lua",
    ["sile.packages.bibtex.styles.abnt"] = "packages/bibtex/styles/abnt.lua"
  },
}
