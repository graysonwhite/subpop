#' The basic area-level small area estimation model.
#' @param mode A single character string for the type of model.
#'  Possible value is "regression". 
#' @param small_areas The small areas. 
#' @param within_variance The within-area variance for the small area model. 
#' @import parsnip
#' @export

basic_area_level <- 
  function(mode = "regression",
           small_areas = NULL,
           within_variance = NULL) {
    if (mode  != "regression") {
      rlang::abort("`mode` should be 'regression'")
    }
    
    args = list(
      small_areas = {{ small_areas }},
      within_variance = {{ within_variance }}
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