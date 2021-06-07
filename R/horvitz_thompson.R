horvitz_thompson <- function(data, response, small_area) {
  # Create dataframe
  dat <- data.frame(
    y = data[[response]],
    small_area = data[[small_area]]
  )

  # Compute estimate
  sae::direct(y = dat$y,
              dom = dat$small_area,
              replace = TRUE)
}
