#' The basic unit-level small area estimation model.
#' @param mode A single character string for the type of model.
#'  Possible value is "regression". 
#' @param areas The small areas. 
#' @import parsnip
#' @export

unit_level <- 
  function(mode = "regression", areas = NULL) {
    if (mode  != "regression") {
      rlang::abort("`mode` should be 'regression'")
    }
    
    args = list(areas = {{ areas }})
    
    parsnip::new_model_spec(
      "unit_level",
      args = args,
      eng_args = NULL,
      mode = mode,
      method = NULL,
      engine = NULL
    )
  }