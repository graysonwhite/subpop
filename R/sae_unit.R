#' The unit-level frequentist (EBLUP) model
#'
#' @param data the data
#' @param formula formula for fixed effects
#' @param small_area character vector of length one. random effects term.
#' @param pop_data population data for the explanatory variable.
#' @importFrom stats model.frame
#' @importFrom dplyr %>%
#' @export

sae_unit <- function(data, formula, small_area, pop_data) {

  # Create model frame
  model_frame <- model.frame(formula, data) %>%
    dplyr::mutate(small_area = data[[small_area]])
  colnames(model_frame) <- c("y", "x", "small_area")

  # Area population sizes
  pop_size <- pop_data %>%
    dplyr::filter(zoneid %in% model_frame$small_area) %>%
    dplyr::select(zoneid, sum) %>%
    dplyr::rename(pop_size = sum,
                  small_area = zoneid)

  # Create population means matrix
  meanxpop <- pop_data %>%
    dplyr::filter(zoneid %in% model_frame$small_area) %>%
    dplyr::select(zoneid, mean) %>%
    dplyr::rename(x = mean,
                  small_area = zoneid)

  # Fit the model
  mod <- sae::eblupBHF(
    formula = model_frame$y ~ model_frame$x,
    dom = model_frame$small_area,
    meanxpop = meanxpop,
    popnsize = pop_size
  )
  mod
}
