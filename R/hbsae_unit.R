#' The unit-level hierarchical Bayesian model
#'
#' @param data the data
#' @param formula formula for fixed effects
#' @param small_area character vector of length one. random effects term.
#' @param pop_data population data for the explanatory variable.
#' @importFrom stats aov model.frame
#' @importFrom dplyr %>%
#' @export

hbsae_unit <- function(data, formula, small_area, pop_data) {
  # Create model frame
  model_frame <- model.frame(formula, data) %>%
    dplyr::mutate(small_area = data[[small_area]])
  colnames(model_frame) <- c("y", "x", "small_area")

  # Area population sizes
  pop_size <- pop_data %>%
    dplyr::filter(zoneid %in% model_frame$small_area) %>%
    dplyr::select(zoneid, sum) %>%
    dplyr::rename(pop_size = sum) %>%
    dplyr::select(pop_size)

  # Create population means matrix
  pop_means <- pop_data %>%
    dplyr::filter(zoneid %in% model_frame$small_area) %>%
    dplyr::select(zoneid, mean) %>%
    dplyr::rename(x = mean) %>%
    tibble::column_to_rownames("zoneid")

  # Create lambda
  # anova <- aov(y ~ small_area, data = model_frame)
  # l <- summary(anova)[[1]]["small_area", "F value"]

  # Fit the model
  mod <- hbsae::fSAE.Unit(
    y = model.frame(formula, data = data)[, 1],
    X = data.frame(X = model.frame(formula, data = data)[,-1]),
    area = data[[small_area]],
    Narea = pop_size$pop_size,
    Xpop = pop_means,
    fpc = TRUE,
   # lambda0 = l,
    silent = T
  )

  # Calculate CoV
  mean_y <- model_frame %>%
    dplyr::group_by(small_area) %>%
    dplyr::summarise(mean_y = mean(y))
  CoV <- hbsae::SE(mod) / mean_y$mean_y

  ## Add to model object
  mod$CoV <- CoV

  # Print model
  mod
}
