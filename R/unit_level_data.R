make_unit_level <- function() {
  parsnip::set_new_model("unit_level")
  
  parsnip::set_model_mode(model = "unit_level", mode = "regression")
  
  # ----------------------------------------------------------------------------
  
  parsnip::set_model_engine(
    "unit_level", 
    mode = "regression", 
    eng = "sae"
  )
  
  parsnip::set_model_engine(
    "unit_level",
    mode = "regression",
    eng = "hbsae"
  )
  
  parsnip::set_model_engine(
    "unit_level",
    mode = "regression",
    eng = "mcmcsae"
  )
  
  parsnip::set_dependency("unit_level", eng = "sae", pkg = "sae")
  parsnip::set_dependency("unit_level", eng = "hbsae", pkg = "hbsae")
  parsnip::set_dependency("unit_level", eng = "mcmcsae", pkg = "mcmcsae")
  
  parsnip::set_model_arg(
    model = "unit_level",
    eng = "sae",
    parsnip = "small_areas",
    original = "dom",
    func = list(pkg = "base", fun = "factor"),
    has_submodel = FALSE
  )
  
  parsnip::set_model_arg(
    model = "unit_level",
    eng = "hbsae",
    parsnip = "small_areas",
    original = "area",
    func = list(pkg = "base", fun = "factor"),
    has_submodel = FALSE
  )
  
  parsnip::set_model_arg(
    model = "unit_level",
    eng = "mcmcsae",
    parsnip = "small_areas",
    original = "factor",
    func = list(pkg = "base", fun = "factor"),
    has_submodel = FALSE
  )
}
