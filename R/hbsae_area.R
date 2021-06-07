#' The area-level hierarchical Bayesian model
#'
#' @param data the data
#' @param formula formula for fixed effects
#' @param small_area character vector of length one. random effects term.
#' @param pop_data population data for the explanatory variable.
#' @param post_strat_data y variable
#' @importFrom stats aov model.frame
#' @importFrom dplyr %>%
#' @export

hbsae_area <- function(data, formula, small_area,
                    pop_data, post_strat_data) {
  # Create unnamed model frame (to call correct y var in a filter)
  mf <- model.frame(formula, data)

  # Create model frame
  model_frame <- model.frame(formula, data) %>%
    dplyr::mutate(small_area = data[[small_area]])
  colnames(model_frame) <- c("y", "x", "small_area")

  # Direct X
  X <- pop_data %>%
    dplyr::filter(zoneid %in% model_frame$small_area) %>%
    dplyr::select(zoneid, mean) %>%
    dplyr::rename(mean_x = mean,
                  small_area = zoneid) %>%
    dplyr::arrange(small_area)

  # Compute direct estimate
  mean <- horvitz_thompson(model_frame, "y", "small_area") %>%
    dplyr::mutate(var = SD^2)

  dir <- post_strat_data %>%
    dplyr::filter(response %in% colnames(mf)[1],
           province %in% unique(data$province)) %>%
    dplyr::arrange(subsection)

  # Create lambda
  anova <- aov(y ~ small_area, data = model_frame)
  l <- summary(anova)[[1]]["small_area", "F value"]

  # Fit the model
  mod <- hbsae::fSAE.Area(
    est.init = dir$est,
    var.init = dir$var,
    X = X %>% dplyr::select(mean_x),
    lambda0 = l
  )

  # Calculate CoV
  CoV <- hbsae::SE(mod) / mean$Direct
  mod$CoV <- CoV

  # Print model
  mod
}
