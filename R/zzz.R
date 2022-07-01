#' vars.lst
#' 
#' List of metrics in `dataset`
#'
#' @export
vars.lst <- c(
    'Maximum Temperature' = 'tmax',
    'Minimum Temperature' = 'tmin',
    'Average Temperature' = 'tmed',
    'Rain precipitation' = 'prec',
    'Maximum Wind Speed' = 'vmax',
    'Average Wind Speed' = 'vmed'
)

#' hvars.lst
#' 
#' List of time recording for metrics in `dataset`
#'
#' @export
hvars.lst <- c(
    'Time of Max Temp' = 'htmax',
    'Time of Min Temp' = 'htmin',
    'Time of Max Wind Speed' = 'hvmax'
)



# .onAttach <- function(libname, pkgname) {
#     packageStartupMessage(
#     )
# }

# .onLoad <- function(libname, pkgname) {
#     oop <- options()
#     opts <- list(
#             pkgname.optname = " option value goes here "
#     )
#     toset <- !(names(opts) %in% names(oop))
#     if(any(toset)) options(opts[toset])
#   
#     invisible()
# }

# .onUnload <- function(libname, pkgname) {
#
# }

