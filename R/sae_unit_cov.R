#' Bootstrapped coefficient of variation for the unit-level EBLUP
#'
#' @param data the data
#' @param formula formula for fixed effects
#' @param small_area character vector of length one. random effects term.
#' @param pop_data population data for the explanatory variable.
#' @param B number of bootstrap samples
#' @importFrom dplyr %>%
#' @export

sae_unit_cov <- function(data, formula, small_area,
                          pop_data, B = 100) {

  # Create empty items for looping
  boots <- list()
  fit <- list()
  mean_df <- list()
  final <- data.frame()

  # Create model frame
  model_frame <- model.frame(formula, data) %>%
    dplyr::mutate(small_area = data[[small_area]])
  colnames(model_frame) <- c("y", "x", "small_area")

  # Nest by small area
  data_nested <- model_frame %>%
    dplyr::mutate(id = small_area) %>%
    dplyr::group_by(small_area) %>%
    tidyr::nest()

  # Bootstrap
  for(i in 1:B){
    for(j in 1:length(unique(model_frame$small_area))) {
      boots[[j]] <- dplyr::sample_n(
        data_nested[[2]][[j]],
        size = length(data_nested[[2]][[j]]$y),
        replace = TRUE
      )
      boots_df <- dplyr::bind_rows(boots)
    }

    fit[[i]] <- sae_unit(boots_df, y ~ x, "id", pop_data)

    mean_df[[i]] <- data.frame(fitted = fit[[i]]$eblup$eblup,
                               subsection = fit[[i]]$eblup$domain)
    if (i %% 50 == 1) {
      print(i)
    }
  }

  # Create final output
  final <- bind_rows(mean_df) %>%
    dplyr::group_by(subsection) %>%
    dplyr::summarize(sd = sd(fitted, na.rm = TRUE))
  mean_y <- model_frame %>%
    dplyr::group_by(small_area) %>%
    dplyr::summarise(mean_y = mean(y, na.rm = TRUE))

  COV <- final$sd / mean_y$mean_y
  names(COV) <- final$subsection

  COV
}
