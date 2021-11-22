# testing the area level model
## load packages
library(tidyverse) 
library(sae)
library(hbsae)
devtools::install_github("graysonwhite/subpop")
library(subpop)
devtools::load_all()

## {sae} code in {subpop}
basic_area_level(within_area_variance = "var_BA_TPA_ADJ") %>%
  set_engine("sae") %>%
  fit(formula = BA_TPA_ADJ ~ tcc + elev, data = subpop::area_dat)

### the {sae} underlying code
sae::mseFH(formula = BA_TPA_ADJ ~ tcc + elev, var_BA_TPA_ADJ,
           data = as.data.frame(subpop::area_dat))

## {hbsae} code in {subpop}
basic_area_level(within_area_variance = "var_BA_TPA_ADJ") %>%
  set_engine("hbsae") %>%
  fit(formula = BA_TPA_ADJ ~ tcc + elev, data = subpop::area_dat)

### the underlying {hbsae} code
hbsae::fSAE.Area(est.init = subpop::area_dat$BA_TPA_ADJ,
                 var.init = subpop::area_dat$var_BA_TPA_ADJ,
                 X = model.matrix(~ tcc + elev,
                                  data = as.data.frame(subpop::area_dat)))
