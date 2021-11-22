# Internal wrapper functions
# These functions allow for easier integration into the tidymodels framework. 
# They take the form "packagename_functionname_wrapper".
# These functinos are for internal use and should not be accessed by the user.


sae_mseFH_wrapper <- function (formula, vardir, method = "REML", MAXITER = 100,
                               PRECISION = 1e-04, B = 0, data) 
{
  data <- as.data.frame(data) # allow for tibbles to be input on user end.
  vardir <- as.name(vardir) # go from string to name
  arg <- list(
    formula = formula,
    vardir = vardir,
    method = method,
    MAXITER = MAXITER,
    PRECISION = PRECISION,
    B = B,
    data = data
  )
  do.call(sae::mseFH, args = arg)
}

hbsae_fSAE.Area_wrapper <- function (formula, data, var.init, x = NULL, ...) 
{
  # set up params hbsae form of function
  data <- as.data.frame(data) # allow for tibbles to be input on user end.
  X <- model.matrix(formula, data)
  est.init <- model.frame(formula, data)[[1]]
  var.init <- eval(as.name(var.init), envir = data)
  if (is.null(x)) {
    x <- X
  }
  do.call(hbsae::fSAE.Area, args = list(
    est.init = est.init,
    var.init = var.init,
    X = X,
    x = x,
    ... = ...)
    )
  
  # run the hbsae function
  # if (nrow(X) > length(est.init)) 
  #   x <- x[names(est.init), , drop = FALSE]
  # funArgs <- list(...)
  # funArgs$v <- funArgs$vpop <- funArgs$nu0 <- funArgs$s20 <- NULL
  # funArgs <- c(list(y = est.init, X = x, area = if (!is.null(names(est.init))) factor(names(est.init), 
  #                                                                                     names(est.init)) else 1:length(est.init), Xpop = X, fpc = FALSE, 
  #                   v = var.init, nu0 = 10000 * length(est.init), s20 = 1), 
  #              funArgs)
  # out <- do.call(hbsae::fSAE.Unit, funArgs)
  # out$type <- "area"
  # out
}


