## Takes a character vector 'x' and converts its elements to a human-readable
## form. The input can be in various formats such as camelCase, snake_case or
## kebab-case. The output string is a 'Capitalized String Of Words' with all
## non-letter symbols removed. The method can additionally replace words in the
## output with the given replacements.
humanize <- function(x, replacements = character(0)) {
    ## Separate camelCase words
    s <- gsub("([[:lower:]])([[:upper:]])", "\\1 \\2", x)
    ## Separate snake_case and kebab-case words
    s <- gsub("_|-", " ", s)
    ## Remove other non-letter symbols
    s <- gsub("[^[:alpha:] ]", "", s)
    sapply(strsplit(s, " "), function(words) {
        lower <- tolower(words)
        capitalized_words <- paste0(toupper(substring(lower, 1, 1)),
                                    substring(lower, 2))
        replaced_words <- sapply(capitalized_words, function(word) {
            replacement <- replacements[word]
            if (!is.na(replacement)) replacement else word
        })
        paste(replaced_words[nchar(replaced_words) > 0], collapse = " ")
    })
}
