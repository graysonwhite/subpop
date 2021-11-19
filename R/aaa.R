#' @import rlang
#' @import parsnip

.onLoad <- function(libname, pkgname) {
  make_basic_area_level()
  make_basic_unit_level()
}
