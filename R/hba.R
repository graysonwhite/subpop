#' The area-level hierarchical Bayesian model
#'
#' @param data the data
#' @param formula formula for fixed effects
#' @param variance within-area variance
#' @importFrom stats model.frame
#' @importFrom dplyr %>%
#' @export

hba <- function(data, formula, variance) {
  # Create model frame
  model_frame <- model.frame(formula, data) %>%
    dplyr::mutate(var = data[[variance]])
  colnames(model_frame) <- c("y", "x", "variance")

  # Fit the model
  mod <- hbsae::fSAE.Area(
    est.init = model_frame$y,
    var.init = model_frame$variance,
    X = model_frame %>% dplyr::select(x)
  )
  # Return model
  return(mod)
}
