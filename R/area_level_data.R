make_area_level <- function() {
  parsnip::set_new_model("area_level")
  parsnip::set_model_mode(model = "area_level", mode = "regression")
  parsnip::set_model_engine(
    "area_level", 
    mode = "regression", 
    eng = "sae"
  )
  parsnip::set_dependency("area_level", eng = "sae", pkg = "sae")
  parsnip::set_model_arg(
    model = "area_level",
    eng = "sae",
    parsnip = "within_variance",
    original = "vardir",
    func = list(pkg = "stats", fun = "var"),
    has_submodel = FALSE
  )
}
