rockspec_format = "3.0"
package = "abnt.sile"
version = "dev-1"

description = {
  summary = "Automatiza a formatação de um trabalho conforme as normas da ABNT...",
  detailed = [[]],
  homepage = "https://github.com/jodros/abnt.sile",
  maintainer = "João Quinaglia",
  license = "MIT"
}

source = {
  url = "git+https://github.com/jodros/abnt.sile.git",
  -- tag = ""
}

dependencies = {"lua >= 5.1" }

build = {
  type = "builtin",
  modules = {
    ["sile.classes.abnt"] = "classes/abnt.lua",
  },
  install = {
    lua = {
        ["sile.packages.bibtex.csl.locales.locales-pt-BR"] = "packages/bibtex/csl/locales/locales-pt-BR.xml",
        ["sile.packages.bibtex.csl.styles.universidade-estadual-de-alagoas-abnt"] = "packages/bibtex/csl/styles/universidade-estadual-de-alagoas-abnt.csl"
  }
}
}

