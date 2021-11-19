#' The basic unit-level small area estimation model.
#' @param mode A single character string for the type of model.
#'  Possible value is "regression". 
#' @param areas The small areas. 
#' @import parsnip
#' @export

basic_unit_level <- 
  function(mode = "regression",
           small_areas = NULL,
           explanatory_means = NULL,
           small_area_size = NULL) {
    if (mode  != "regression") {
      rlang::abort("`mode` should be 'regression'")
    }
    
    args = list(small_areas = {{ small_areas }},
                explanatory_means = {{ explanatory_means }},
                small_area_size = {{ small_area_size }})
    
    parsnip::new_model_spec(
      "basic_unit_level",
      args = args,
      eng_args = NULL,
      mode = mode,
      method = NULL,
      engine = NULL
    )
  }