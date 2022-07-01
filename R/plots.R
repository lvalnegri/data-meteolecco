#' facet_metric
#' 
#' Build a yearly-faceted daily plot with averages  
#'
#' @param x   month of the year as integer
#' @param y   acronym of a metric (see `vars.lst`)
#' @param ttl 
#' 
#' 
#' @return a ggplot2 plot
#' 
#' @author Luca Valnegri, \email{l.valnegri@datamaps.co.uk}
#' 
#' @import data.table ggplot2
#' 
#' @export
#' 
facet_metric <- function(x, y, ttl = NA, yl = NA){
    y0 <- meteolecco::dataset[mese == x, .(anno, giorno, X = get(y))]
    y0[, mean(X), anno]
    m <- mean(y0$X)
    gp <- ggplot(y0, aes(giorno, X)) +
            geom_line() + 
            geom_hline(data = y0[, .(m = mean(X)), anno], aes(yintercept = m), color = 'orange', size = 0.6) +
            geom_hline(yintercept = m, color = 'red', size = 0.5, linetype = 'dotted') +
            geom_smooth(method = 'lm', se = FALSE) +
            facet_wrap(anno~., ncol =4) +
            labs(
                title = ttl,
                x = 'Day',
                y = yl,
                caption = 'Data from http://www.meteolecco.it'
            )
    if(is.na(ttl)) gp <- gp + theme(plot.title = element_blank())
    if(is.na(yl)) gp <- gp + theme(axis.title.y = element_blank())
    
    gp
}
