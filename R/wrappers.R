# Internal wrapper functions
# These functions allow for easier integration into the tidymodels framework. 
# They take the form "packagename_functionname_wrapper".
# These functinos are for internal use and should not be accessed by the user.


sae_mseFH_wrapper <- function (formula, vardir, method = "REML", MAXITER = 100,
                               PRECISION = 1e-04, B = 0, data) 
{
  data <- as.data.frame(data) # allow for tibbles to be input on user end.
  result <- list(est = NA, mse = NA)
  namevar <- vardir # take as a string in this case.
  if (!missing(data)) {
    formuladata <- model.frame(formula, na.action = na.omit, 
                               data)
    X <- model.matrix(formula, data)
    vardir <- data[, namevar]
  }
  else {
    formuladata <- model.frame(formula, na.action = na.omit)
    X <- model.matrix(formula)
  }
  y <- formuladata[, 1]
  if (attr(attributes(formuladata)$terms, "response") == 1) 
    textformula <- paste(formula[2], formula[1], formula[3])
  else textformula <- paste(formula[1], formula[2])
  if (length(na.action(formuladata)) > 0) 
    stop("Argument formula=", textformula, " contains NA values.")
  if (any(is.na(vardir))) 
    stop("Argument vardir=", namevar, " contains NA values.")
  result$est <- sae::eblupFH(y ~ X - 1, vardir, method, MAXITER, 
                        PRECISION, B)
  if (result$est$fit$convergence == FALSE) {
    warning("The fitting method does not converge.\n")
    return(result)
  }
  A <- result$est$fit$refvar
  m <- dim(X)[1]
  p <- dim(X)[2]
  g1d <- rep(0, m)
  g2d <- rep(0, m)
  g3d <- rep(0, m)
  mse2d <- rep(0, m)
  Vi <- 1/(A + vardir)
  Bd <- vardir/(A + vardir)
  SumAD2 <- sum(Vi^2)
  XtVi <- t(Vi * X)
  Q <- solve(XtVi %*% X)
  if (method == "REML") {
    VarA <- 2/SumAD2
    for (d in 1:m) {
      g1d[d] <- vardir[d] * (1 - Bd[d])
      xd <- matrix(X[d, ], nrow = 1, ncol = p)
      g2d[d] <- (Bd[d]^2) * xd %*% Q %*% t(xd)
      g3d[d] <- (Bd[d]^2) * VarA/(A + vardir[d])
      mse2d[d] <- g1d[d] + g2d[d] + 2 * g3d[d]
    }
  }
  else if (method == "ML") {
    VarA <- 2/SumAD2
    b <- (-1) * sum(diag(Q %*% (t((Vi^2) * X) %*% X)))/SumAD2
    for (d in 1:m) {
      g1d[d] <- vardir[d] * (1 - Bd[d])
      xd <- matrix(X[d, ], nrow = 1, ncol = p)
      g2d[d] <- (Bd[d]^2) * xd %*% Q %*% t(xd)
      g3d[d] <- (Bd[d]^2) * VarA/(A + vardir[d])
      mse2d[d] <- g1d[d] + g2d[d] + 2 * g3d[d] - b * (Bd[d]^2)
    }
  }
  else {
    SumAD <- sum(Vi)
    VarA <- 2 * m/(SumAD^2)
    b <- 2 * (m * SumAD2 - SumAD^2)/(SumAD^3)
    for (d in 1:m) {
      g1d[d] <- vardir[d] * (1 - Bd[d])
      xd <- matrix(X[d, ], nrow = 1, ncol = p)
      g2d[d] <- (Bd[d]^2) * xd %*% Q %*% t(xd)
      g3d[d] <- (Bd[d]^2) * VarA/(A + vardir[d])
      mse2d[d] <- g1d[d] + g2d[d] + 2 * g3d[d] - b * (Bd[d]^2)
    }
  }
  result$mse <- mse2d
  return(result)
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
  
  # run the hbsae function
  if (nrow(X) > length(est.init)) 
    x <- x[names(est.init), , drop = FALSE]
  funArgs <- list(...)
  funArgs$v <- funArgs$vpop <- funArgs$nu0 <- funArgs$s20 <- NULL
  funArgs <- c(list(y = est.init, X = x, area = if (!is.null(names(est.init))) factor(names(est.init), 
                                                                                      names(est.init)) else 1:length(est.init), Xpop = X, fpc = FALSE, 
                    v = var.init, nu0 = 10000 * length(est.init), s20 = 1), 
               funArgs)
  out <- do.call(hbsae::fSAE.Unit, funArgs)
  out$type <- "area"
  out
}

