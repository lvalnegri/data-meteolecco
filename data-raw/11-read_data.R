# METEOLECCO Data Download

Rfuns::load_pkgs('data.table', 'fasttime', 'fst', 'rvest')

scarica_tabella <- function(m, a){
    data.table(
        anno = 2000 + a, 
        mese = m,
        paste0('http://www.meteolecco.it/estrmese.php?mese=', ifelse(m < 10, '0', ''), m, 2000 + a) |> 
            read_html() |> 
            html_elements('.text2 tr+ tr td') |> 
            html_text() |> 
            matrix(ncol = 8, byrow = TRUE) |> 
            as.data.table()
    )
}

tutto <- FALSE
if(tutto){
    y <- data.table()
    for(i in 3:12) y <- rbindlist(list( y, scarica_tabella(i, 4) ))
    for(i in 1:12)
        for(j in 5:21)
             y <- rbindlist(list( y, scarica_tabella(i, j) ))
    for(i in 1:6) y <- rbindlist(list( y, scarica_tabella(i, 22) ))
} else {
    m <- month(Sys.Date())
    a <- year(Sys.Date())
    y <- scarica_tabella(m, a - 2000)
}
cols <- c('V4', 'V5', 'V7')
y[, (cols) := lapply(.SD, \(x) x = gsub('[^0-9.:]', '', x)), .SDcols = cols]
y[, c('tmax', 'htmax') := tstrsplit(V2, split = ' °Ch. ')]
y[, c('tmin', 'htmin') := tstrsplit(V3, split = ' °Ch. ')]
y[, c('vmax', 'hvmax') := tstrsplit(V6, split = ' Km/hh. ')]
y[, c('V2', 'V3', 'V6') := NULL]
y[, periodo := paste0(anno, '-', ifelse(mese < 10, '0', ''), mese, '-', ifelse(nchar(V1) == 1, '0', ''), V1)]
y |> 
    setnames(c('V1', 'V4', 'V5', 'V7', 'V8'), c('giorno', 'tmed', 'prec', 'vmed', 'vdir')) |> 
    setcolorder(c(
        'periodo', 'anno', 'mese', 'giorno',
        'tmax', 'htmax', 'tmin', 'htmin', 'tmed',
        'prec', 
        'vmax', 'hvmax', 'vmed', 'vdir'
    ))
y[, `:=`(
    htmax = fastPOSIXct(paste(periodo, htmax), tz = 'CET', required.components = 5),    
    htmin = fastPOSIXct(paste(periodo, htmin), tz = 'CET', required.components = 5),
    hvmax = fastPOSIXct(paste(periodo, hvmax), tz = 'CET', required.components = 5),
    periodo = as.Date(periodo)
)]


cols <- c('giorno', 'tmax', 'tmin', 'tmed', 'prec', 'vmax', 'vmed')
y[, (cols) := lapply(.SD, as.numeric), .SDcols = cols]
y <- y[!is.na(tmax)]

if(!tutto){
    y0 <- read_fst('./data-raw/dataset', as.data.table = TRUE)
    y0 <- y0[!(anno == a & mese == m)]
    y <- rbindlist(list(y0, y))
}

write_fst(y, './data-raw/dataset')
fwrite(y, './data-raw/dataset.csv')

fn <- 'dataset'
assign(fn, y)
save( list = fn, file = file.path('data', paste0(fn, '.rda')), version = 3, compress = 'gzip' )
dd_dbm_do('meteolecco', 'w', fn, y)

rm(list = ls())
gc()
