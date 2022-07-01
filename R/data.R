#' @importFrom data.table data.table
NULL

#' dataset
#'
#' Daily data about temperatures and wind in Lecco, Italy. 
#' 
#' @format A data.table with the following columns:
#' \describe{
#'   \item{\code{ periodo }{ Date in usual YYYY-MM-DD format } },
#'   \item{\code{ anno }{ Year numeric } },
#'   \item{\code{ mese }{ Month numeric } },
#'   \item{\code{ giorno }{ Day numeric } },
#'   \item{\code{ tmax }{ Maximum Temperature } },
#'   \item{\code{ htmax }{ Time of the day when `tmax` occured } },
#'   \item{\code{ tmin }{ Minimum Temperature } },
#'   \item{\code{ htmin }{ Time of the day when `tmax` occured } },
#'   \item{\code{ tmed }{ Average Temperature } },
#'   \item{\code{ prec }{ Rain precipitaion in mm } },
#'   \item{\code{ vmax }{ Maximum Wind Speed } },
#'   \item{\code{ hvmax }{ Time of the day when `vmax` occured } },
#'   \item{\code{ vmed }{ Average Wind Speed } },
#'   \item{\code{ vdir }{ Main Wind Direction } }
#' }
#'
'dataset'
