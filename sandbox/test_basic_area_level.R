# testing the area level model
## load packages
library(tidyverse) 
devtools::load_all()

## make area level data
dat <- readRDS("sandbox/IDdata.rds")$pltassgn %>%
  group_by(COUNTYFIPS) %>%
  summarize(x1 = mean(tcc),
            x2 = mean(elev),
            y_var = var(BA_TPA_ADJ) / n(),
            y = mean(BA_TPA_ADJ)) %>%
  filter(y_var != 0) 

## {sae}
basic_area_level(within_area_variance = "y_var") %>%
  set_engine("sae") %>%
  fit(formula = y ~ x1 + x2, data = dat)

sae::mseFH(y ~ x1 + x2, y_var, data = as.data.frame(dat))

## {hbsae}
basic_area_level(within_area_variance = "y_var") %>%
  set_engine("hbsae") %>%
  fit(formula = y ~ x1 + x2, data = dat)

hbsae::fSAE.Area(est.init = dat$y,
                 var.init = dat$y_var,
                 X = model.matrix(~ x1 + x2, data = dat))
