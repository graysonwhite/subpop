#' The basic area-level small area estimation model.
#' @param mode A single character string for the type of model.
#'  Possible value is "regression". 
#' @param within_variance The within-area variance for the small area model. 
#' @import parsnip
#' @export

area_level <- 
  function(mode = "regression", within_variance = NULL) {
    if (mode  != "regression") {
      rlang::abort("`mode` should be 'regression'")
    }
    
    args = list(within_variance = {{ within_variance }})
    
    parsnip::new_model_spec(
      "area_level",
      args = args,
      eng_args = NULL,
      mode = mode,
      method = NULL,
      engine = NULL
    )
  }