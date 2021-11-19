#' The basic area-level small area estimation model.
#' @param mode A single character string for the type of model.
#'  Possible value is "regression". 
#' @param within_area_variance The within-area variance for the small area model. 
#' @import parsnip
#' @export

basic_area_level <- 
  function(mode = "regression",
           # domains = NULL,
           within_area_variance = NULL) {
    if (mode  != "regression") {
      rlang::abort("`mode` should be 'regression'")
    }
    
    args = list(
      # domains = {{ domains }},
      within_area_variance = {{ within_area_variance }}
      )
    
    parsnip::new_model_spec(
      "basic_area_level",
      args = args,
      eng_args = NULL,
      mode = mode,
      method = NULL,
      engine = NULL
    )
  }