#############################################
# Create databases e tables in MySQL server #
#############################################

library(Rfuns)

dbn <- 'meteolecco'
dd_create_db(dbn)

## TABLE <table name> -----------------
x <- "
    `periodo` DATE NOT NULL,
    `anno` SMALLINT(4) UNSIGNED NOT NULL,
    `mese` TINYINT(2) UNSIGNED NOT NULL,
    `giorno` TINYINT(2) UNSIGNED NOT NULL,
    `tmax` DECIMAL(3,1) NOT NULL,
    `htmax` DATETIME NOT NULL,
    `tmin` DECIMAL(3,1) NOT NULL,
    `htmin` DATETIME NOT NULL,
    `tmed` DECIMAL(3,1) NOT NULL,
    `prec` DECIMAL(5,2) NOT NULL,
    `vmax` DECIMAL(3,1) NOT NULL,
    `hvmax` DATETIME NOT NULL,
    `vmed` DECIMAL(3,1) NOT NULL,
    `vdir` CHAR(3) NOT NULL,
    PRIMARY KEY (`periodo`),
    KEY `anno` (`anno`),
    KEY `mese` (`mese`),
    KEY `giorno` (`giorno`)
"
dd_create_dbtable('dataset', dbn, x)

## END --------------------------------
rm(list = ls())
gc()
