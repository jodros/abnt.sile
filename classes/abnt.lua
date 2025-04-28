local plain = require("classes.plain")

local class = pl.class(plain)
class._name = "abnt"

class.frontFrameset = {
    escola = {
        top = "4cm",
        left = "3cm",
        right = "100%pw-3cm",
        bottom = "8cm",
    },
    autor = {
        top = "9cm",
        bottom = "13cm",
        left = "left(escola)",
        right = "right(escola)"
    },
    titulo = {
        top = "14cm",
        bottom = "17cm",
        left = "left(escola)",
        right = "right(escola)"
    },
    data = {
        top = "90%ph",
        left = "left(escola)",
        right = "right(escola)",
        height = "0"
    }
}

class.defaultFrameset = {
    content = {
        left = "3cm",
        right = "100%pw-2cm",
        top = "3cm",
        bottom = "top(footnotes)"
    },
    folio = {
        left = "left(content)",
        right = "right(content)",
        top = "2cm",
        bottom = "top(content)-15pt"
    },
    footnotes = {
        left = "left(content)",
        right = "right(content)",
        height = "0",
        bottom = "100%ph-2cm"
    }
}
class.firstContentFrame = "content"

function class:_init(options)
    options = options or {}
    options.papersize = "a4"
    plain._init(self, options)

    self:loadPackage("bibtex")
    self:loadPackage("tableofcontents")
    self:loadPackage("frametricks")
    self:loadPackage("masters", {{ id = "right", firstContentFrame = self.firstContentFrame, frames = self.defaultFrameset }})
    self:loadPackage("twoside", { oddPageMaster = "right", evenPageMaster = "left" })
 
    SILE.languageSupport.loadLanguage("pt")
    SILE.settings:set("document.language", "pt")
    SILE.settings:set("font.family", "Times New Roman")
    SILE.settings:set("font.size", 12)
    SILE.call("bibliographystyle", { lang = "pt-BR", style = "universidade-estadual-de-alagoas-abnt" })
    
    SILE.call("define", { command = "foliostyle"}, function (_, content)
        if SILE.scratch.counters.folio.value % 2 ~= 0 then
            SILE.call("raggedleft", {}, content)
        else
            SILE.call("noindent")
            SILE.call("raggedright", {}, content)
        end
    end)
    
    SILE.call("define", { command = "tableofcontents:header"}, function (_, _)
        SILE.call("par")
        SILE.call("noindent")
        SILE.call("tableofcontents:headerfont", {}, function ()
            SILE.typesetter:typeset("Sumário")
        end)
        SILE.call("medskip")
        SILE.call("nofoliothispage")
    end)
  
end

function class:declareOptions()
    plain.declareOptions(self)
end

function class:registerCommands()
    plain.registerCommands(self)

    for name in pairs(self.frontFrameset) do
        self:registerCommand(name, function(options, content)
            SILE.call("typeset-into", { frame = name }, function()
                SILE.call("center", {}, function()
                    SILE.call("font", { weight = 800 }, function()
                        SILE.process(content)
                    end)
                end)
            end)
        end)
    end

    self:registerCommand("capa", function(options, content)
        SILE.call("pagetemplate", { ["first-content-frame"] = "autor" }, function()
            for name, frame in pairs(self.frontFrameset) do
                SILE.call("frame", {
                    id = name,
                    left = frame.left,
                    right = frame.right,
                    top = frame.top,
                    bottom = frame.bottom
                })
            end
        end)
        SILE.call("nofoliothispage")
        SILE.process(content)
        SILE.call("pagebreak")
    end, "Capa")

    self:registerCommand("capitulo", function(options, content)
        SILE.call("supereject")
        SILE.call("tocentry", {}, content)
        SILE.call("increment-counter", { id = "chapters" })
        SILE.call("font", { weight = "700", size = "14pt" }, function ()
            SILE.process(content)
        end)
        SILE.call("skip", { height = "7%ph" })
        SILE.call("nofoliothispage")
    end)
    
    -- self:registerCommand("lista:ilustracoes", function(options, content)
    -- end, "Lista de ilustrações")

    -- self:registerCommand("lista:tabelas", function(options, content)
    -- end, "Lista de tabelas")

    -- self:registerCommand("lista:abreviaturas-siglas", function(options, content)
    -- end, "Lista de abreviaturas e siglas")

    -- self:registerCommand("lista:simbolos", function(options, content)
    -- end, "Lista de simbolos")

    -- self:registerCommand("indice", function(options, content)
    -- end, "indice")
end

return class
