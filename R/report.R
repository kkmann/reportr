#' PDF report template for RMarkdown
#'
#' @param ... further arguments pssed to rmarkdown::pdf_document()
#'
#' @export
report <- function(...) {

    base <- rmarkdown::pdf_document(
        ...,
        template = system.file(
            "rmarkdown/templates/report/resources/template.tex",
            package = "reportr"
        )
    )

    base$knitr$opts_chunk$prompt     <- FALSE
    base$knitr$opts_chunk$comment    <- NA
    base$knitr$opts_chunk$highlight  <- TRUE
    base$knitr$opts_chunk$echo       <- FALSE
    base$knitr$opts_chunk$dpi        <- 300 # printing quality
    base$knitr$opts_chunk$fig.pos    <- 'H' #'!htbp'
    base$knitr$opts_chunk$out.extra  <- '' # ensures latex code for figure

    base$knitr$opts_chunk$dev.args   <- list(pointsize = 4)
    base$knitr$opts_chunk$fig.width  <- 7
    base$knitr$opts_chunk$fig.height <- 3

    return(base)

}



#' HTML report template for Rmarkdown
#'
#' @param ... further arguments pssed to rmarkdown::html_document()
#'
#' @export
html_report <- function(...) {

    base <- rmarkdown::html_document(toc = TRUE, toc_depth = 3, toc_float = TRUE,
                                     code_folding = "hide", smart = TRUE, self_contained = TRUE
    )

    base$knitr$opts_chunk$prompt     <- FALSE
    base$knitr$opts_chunk$comment    <- NA

    base$knitr$opts_chunk$fig.width  <- 8
    base$knitr$opts_chunk$fig.height <- 8/1.618

    return(base)

}


#' HTML report template for Rmarkdown
#'
#' @param ... further arguments pssed to rmarkdown::html_document()
#'
#' @export
print_meta <- function(
    `git commit` = if (!system('git status', ignore.stdout = TRUE, ignore.stderr = TRUE)) {
            sprintf("sha1:%s", system('git rev-parse --verify HEAD', intern = TRUE))
        } else {
            NULL
        },
    `git clean WD` = if (!system('git status', ignore.stdout = TRUE, ignore.stderr = TRUE)) {
            ifelse(system('git diff-index --quiet HEAD') == 0, 'yes', 'no')
        } else {
            NULL
        },
    ...
) {

    args <- c(as.list(environment()), list(...))

    args <- args[!sapply(args, is.null)]

    tibble(
        kableExtra::cell_spec(names(args), align = "c", color = "black"),
        kableExtra::cell_spec(as.character(args))
    ) %>%
        kableExtra::kable(escape = FALSE, col.names = rep("", ncol(.))) %>%
        kableExtra::kable_styling("striped", full_width = F) %>%
        kableExtra::column_spec(1, bold = TRUE) %>%
        kableExtra::column_spec(2, width = "5in")

}

