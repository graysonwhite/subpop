make_area_level <- function() {
  parsnip::set_new_model("area_level")
  
  parsnip::set_model_mode(model = "area_level", mode = "regression")
  
  # ----------------------------------------------------------------------------
  
  # parsnip::set_model_arg(
  #   model = "area_level",
  #   eng = "sae",
  #   parsnip = "small_areas",
  #   original = "dom",
  #   func = list(pkg = "base", fun = "factor"),
  #   has_submodel = FALSE
  # )
  
  parsnip::set_model_arg(
    model = "area_level",
    eng = "hbsae",
    parsnip = "small_areas",
    original = "area",
    func = list(pkg = "base", fun = "factor"),
    has_submodel = FALSE
  )
  
  parsnip::set_model_arg(
    model = "area_level",
    eng = "mcmcsae",
    parsnip = "small_areas",
    original = "factor",
    func = list(pkg = "base", fun = "factor"),
    has_submodel = FALSE
  )
  
  parsnip::set_model_engine(
    "area_level", 
    mode = "regression", 
    eng = "sae"
  )
  
  parsnip::set_model_engine(
    "area_level",
    mode = "regression",
    eng = "hbsae"
  )
  
  parsnip::set_model_engine(
    "area_level",
    mode = "regression",
    eng = "mcmcsae"
  )
  
  parsnip::set_dependency("area_level", eng = "sae", pkg = "sae")
  parsnip::set_dependency("area_level", eng = "hbsae", pkg = "hbsae")
  parsnip::set_dependency("area_level", eng = "mcmcsae", pkg = "mcmcsae")
  
  parsnip::set_model_arg(
    model = "area_level",
    eng = "sae",
    parsnip = "within_variance",
    original = "vardir",
    func = list(pkg = "stats", fun = "var"),
    has_submodel = FALSE
  )
  
  parsnip::set_model_arg(
    model = "area_level",
    eng = "hbsae",
    parsnip = "within_variance",
    original = "var.init",
    func = list(pkg = "stats", fun = "var"),
    has_submodel = FALSE
  )
  
  parsnip::set_model_arg(
    model = "area_level",
    eng = "mcmcsae",
    parsnip = "within_variance",
    original = "Q0",
    func = list(pkg = "stats", fun = "var"),
    has_submodel = FALSE
  )
  
  parsnip::set_fit(
    model = "area_level",
    mode = "regression",
    eng = "sae",
    value = list(
      interface = "formula",
      protect = c("formula", "data"),
      func = c(pkg = "sae", fun = "eblupFH"),
      defaults = list()
    )
  )
}
