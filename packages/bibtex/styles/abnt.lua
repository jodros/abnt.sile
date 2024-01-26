local Bibliography = require("packages.bibtex.bibliography")

local ABNTStyles = pl.tablex.merge(Bibliography.Style, {

    Article = function(_ENV)
    end,

    Book = function(_ENV)
        local pub = publisher or institution or organization or howpublished
        return andAuthors, ". ", italic(title), ". ", optional(location), ": ", optional(pub, ", "), optional(date), "."
    end,

    Thesis = function(_ENV)
    end
}, true)

return pl.tablex.merge(ABNTStyles, {
    -- Add fallback mappings for usual BibTeX keys not defined above.
    Booklet = ABNTStyles.Book,
    Conference = ABNTStyles.Book,
    Inbook = ABNTStyles.Book,
    Incollection = ABNTStyles.Book,
    Inproceedings = ABNTStyles.Book,
    Manual = ABNTStyles.Book,
    Misc = ABNTStyles.Book, -- NOTE: So we assume at least a title...
    Proceedings = ABNTStyles.Book,
    Techreport = ABNTStyles.Book,
    Phdthesis = ABNTStyles.Thesis,
    Mastersthesis = ABNTStyles.Thesis,
    Unpublished = ABNTStyles.Book
}, true)
