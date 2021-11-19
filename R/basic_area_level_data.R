make_basic_area_level <- function() {
  parsnip::set_new_model("basic_area_level")
  
  parsnip::set_model_mode(model = "basic_area_level", mode = "regression")
  
  # ----------------------------------------------------------------------------
  
  # parsnip::set_model_arg(
  #   model = "basic_area_level",
  #   eng = "sae",
  #   parsnip = "domains",
  #   original = "dom",
  #   func = list(pkg = "base", fun = "factor"),
  #   has_submodel = FALSE
  # )

  # parsnip::set_model_arg(
  #   model = "basic_area_level",
  #   eng = "hbsae",
  #   parsnip = "domains",
  #   original = "area",
  #   func = list(pkg = "base", fun = "factor"),
  #   has_submodel = FALSE
  # )
  
  # parsnip::set_model_arg(
  #   model = "basic_area_level",
  #   eng = "mcmcsae",
  #   parsnip = "domains",
  #   original = "factor",
  #   func = list(pkg = "base", fun = "factor"),
  #   has_submodel = FALSE
  # )
  
  parsnip::set_model_engine(
    "basic_area_level", 
    mode = "regression", 
    eng = "sae"
  )
  
  parsnip::set_model_engine(
    "basic_area_level",
    mode = "regression",
    eng = "hbsae"
  )
  
  # parsnip::set_model_engine(
  #   "basic_area_level",
  #   mode = "regression",
  #   eng = "mcmcsae"
  # )
  
  parsnip::set_dependency("basic_area_level", eng = "sae", pkg = "sae")
  parsnip::set_dependency("basic_area_level", eng = "hbsae", pkg = "hbsae")
  # parsnip::set_dependency("basic_area_level", eng = "mcmcsae", pkg = "mcmcsae")
  
  parsnip::set_model_arg(
    model = "basic_area_level",
    eng = "sae",
    parsnip = "within_area_variance",
    original = "vardir",
    func = list(pkg = "stats", fun = "var"),
    has_submodel = FALSE
  )
  
  parsnip::set_model_arg(
    model = "basic_area_level",
    eng = "hbsae",
    parsnip = "within_area_variance",
    original = "var.init",
    func = list(pkg = "stats", fun = "var"),
    has_submodel = FALSE
  )
  
  # parsnip::set_model_arg(
  #   model = "basic_area_level",
  #   eng = "mcmcsae",
  #   parsnip = "within_variance",
  #   original = "Q0",
  #   func = list(pkg = "stats", fun = "var"),
  #   has_submodel = FALSE
  # )
  
  parsnip::set_fit(
    model = "basic_area_level",
    mode = "regression",
    eng = "sae",
    value = list(
      interface = "formula",
      protect = c("formula", "data"),
      func = c(fun = "sae_mseFH_wrapper"),
      defaults = list()
    )
  )
  
  parsnip::set_fit(
    model = "basic_area_level",
    mode = "regression",
    eng = "hbsae",
    value = list(
      interface = "matrix",
      protect = c("formula", "data"),
      func = c(pkg = "hbsae", fun = "fSAE.Area"),
      defaults = list()
    )
  )
}
