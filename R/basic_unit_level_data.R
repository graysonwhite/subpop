make_basic_unit_level <- function() {
  parsnip::set_new_model("basic_unit_level")
  
  parsnip::set_model_mode(model = "basic_unit_level", mode = "regression")
  
  # ----------------------------------------------------------------------------
  
  parsnip::set_model_engine(
    "basic_unit_level", 
    mode = "regression", 
    eng = "sae"
  )
  
  parsnip::set_model_engine(
    "basic_unit_level",
    mode = "regression",
    eng = "hbsae"
  )
  
  parsnip::set_model_engine(
    "basic_unit_level",
    mode = "regression",
    eng = "mcmcsae"
  )
  
  parsnip::set_dependency("basic_unit_level", eng = "sae", pkg = "sae")
  parsnip::set_dependency("basic_unit_level", eng = "hbsae", pkg = "hbsae")
  parsnip::set_dependency("basic_unit_level", eng = "mcmcsae", pkg = "mcmcsae")
  
  parsnip::set_model_arg(
    model = "basic_unit_level",
    eng = "sae",
    parsnip = "small_areas",
    original = "dom",
    func = list(pkg = "base", fun = "factor"),
    has_submodel = FALSE
  )
  
  parsnip::set_model_arg(
    model = "basic_unit_level",
    eng = "sae",
    parsnip = "explanatory_means",
    original = "meanxpop",
    func = list(pkg = "base", fun = "mean"),
    has_submodel = FALSE
  )
  
  parsnip::set_model_arg(
    model = "basic_unit_level",
    eng = "sae",
    parsnip = "small_area_size",
    original = "popnsize",
    func = list(pkg = "base", fun = "sum"),
    has_submodel = FALSE
  )
  
  parsnip::set_model_arg(
    model = "basic_unit_level",
    eng = "hbsae",
    parsnip = "small_areas",
    original = "area",
    func = list(pkg = "base", fun = "factor"),
    has_submodel = FALSE
  )
  
  parsnip::set_model_arg(
    model = "basic_unit_level",
    eng = "mcmcsae",
    parsnip = "small_areas",
    original = "factor",
    func = list(pkg = "base", fun = "factor"),
    has_submodel = FALSE
  )
  
  parsnip::set_fit(
    model = "basic_unit_level",
    mode = "regression",
    eng = "sae",
    value = list(
      interface = "formula",
      protect = c("formula", "data"),
      func = c(pkg = "sae", fun = "eblupBHF"),
      defaults = list()
    )
  )
}
