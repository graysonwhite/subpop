## code to prepare `area_dat` dataset goes here

usethis::use_data(area_dat, overwrite = TRUE)

library(dplyr) 

area_dat <- readRDS("sandbox/IDdata.rds")$pltassgn %>%
  group_by(COUNTYFIPS) %>%
  summarize(tcc = mean(tcc),
            elev = mean(elev),
            ppt = mean(ppt),
            tmean = mean(tmean),
            tmin01 = mean(tmin01),
            tnt = mean(tnt),
            var_BA_TPA_ADJ = var(BA_TPA_ADJ) / n(),
            var_FOREST_PROP_ADJ = var(FOREST_PROP_ADJ) / n(),
            var_VOLCFNET_TPA_ADJ = var(VOLCFNET_TPA_ADJ) / n(),
            var_COUNT_TPA_ADJ = var(COUNT_TPA_ADJ) / n(),
            BA_TPA_ADJ = mean(BA_TPA_ADJ),
            FOREST_PROP_ADJ = mean(FOREST_PROP_ADJ),
            VOLCFNET_TPA_ADJ = mean(VOLCFNET_TPA_ADJ),
            COUNT_TPA_ADJ = mean(COUNT_TPA_ADJ)) %>%
  filter(var_BA_TPA_ADJ != 0,
         var_FOREST_PROP_ADJ != 0,
         var_VOLCFNET_TPA_ADJ != 0,
         var_COUNT_TPA_ADJ != 0)

usethis::use_data(area_dat, overwrite = TRUE)

devtools::document()
