#' The area-level frequentist (EBLUP) model
#'
#' @param data the data
#' @param formula formula for fixed effects
#' @param small_area character vector of length one. random effects term.
#' @param pop_data population data for the explanatory variable.
#' @param post_strat_data y variable
#' @importFrom stats model.frame
#' @importFrom dplyr %>%
#' @export

sae_area <- function(data, formula, small_area,
                      pop_data, post_strat_data) {
  # Create model frame
  model_frame <- model.frame(formula, data) %>%
    dplyr::mutate(small_area = data[[small_area]])
  colnames(model_frame) <- c("y", "x", "small_area")
  model_frame

  mf <- model.frame(formula, data)

  dir <- post_strat_data %>%
    dplyr::filter(response %in% colnames(mf)[1],
           province %in% unique(data$province)) %>%
    dplyr::arrange(subsection)

  # Direct X
  X <- pop_data %>%
    dplyr::filter(zoneid %in% model_frame$small_area) %>%
    dplyr::select(zoneid, mean) %>%
    dplyr::rename(mean_x = mean,
                  small_area = zoneid) %>%
    dplyr::arrange(small_area)

  # Join pop and dir
  dat <- dir %>%
    dplyr::left_join(X, by = c("subsection" = "small_area"))

  # Fit the model
  mod <- sae::mseFH(formula = dat$est ~ dat$mean_x,
                    vardir = dat$var)
  mod

}
