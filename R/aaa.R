#' @import rlang
#' @import parsnip

.onLoad <- function(libname, pkgname) {
  make_area_level()
  make_unit_level()
}
