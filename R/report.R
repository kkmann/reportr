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
