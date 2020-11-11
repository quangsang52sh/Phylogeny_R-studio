#####QUANG-SANG-Modified-####################
#################################
######Alignment###############
options(repos = c(CRAN = "http://cran.rstudio.com",CRAN="http://cran.us.r-project.org"))
#source("https://bioconductor.org/biocLite.R")
rm(list = ls())
if (!require("ape")) {
  BiocManager::install("ape")
  library(ape) 
}
if (!require("vegan")) {
  BiocManager::install("vegan")
  library(vegan) 
}
if (!require("phangorn")) {
  BiocManager::install("phangorn")
  library(phangorn) 
}
#setwd("/home/tsang/Desktop/")
#Read file fasta
myfile <- read.dna(file.choose(), format = "fasta") # read data dna from alignment
#setwd("/home/tsang/Documents/")
dat <- as.phyDat(myfile) # Convert phydat format to run modeltest
#Input modeltest Function 
aic.weights <- function(aic){
  diff.aic <- aic-min(aic)
  exp(-0.5 * diff.aic) / sum(exp(-0.5 * diff.aic))
}
modelTest <- function (object, tree = NULL, model = "all", G = TRUE, I = TRUE, FREQ=FALSE, k = 4, 
                       control = pml.control(epsilon = 1e-08, maxit = 10, trace = 1), 
                       multicore = FALSE, mc.cores = NULL) ##c("JC", "F81", "K80","HKY", "SYM", "GTR")
  #G:logical, TRUE (default) if (discrete) Gamma model should be tested
  #I:logical, TRUE (default) if invariant sites should be tested
  #FREQ:logical, FALSE (default) if TRUE amino acid frequencies will be estimated.
  #k:number of rate classes ("GTR","..+I","..+G","..+G+I")
  #control:A list of parameters for controlling the fitting process.
  #multicore:logical, whether models should estimated in parallel.
  #mc.cores:The number of cores to use, i.e. at most how many child processes will be run simultaneously. Must be at least one, and parallelization requires at least two cores.
  ##Chose optimize model with AIC value is the smallest
  ##Next, chose the parameter about "Base frequencies", "Proportion of invariant sites", "Shape parameter"
{    
  #    multicore <- mc.cores > 1L
  if(multicore && is.null(mc.cores)){
    mc.cores <- detectCores()
  }
  if (inherits(object,"phyDat")) 
    data <- object
  if (inherits(object,"pml")) {
    data <- object$data
    if (is.null(tree)) 
      tree <- object$tree
  }
  
  if(attr(data, "type")=="DNA") type <- c("JC", "F81", "K80", "HKY", "TrNe", 
                                          "TrN", "TPM1", "K81", "TPM1u", "TPM2", "TPM2u", "TPM3", "TPM3u", 
                                          "TIM1e", "TIM1", "TIM2e", "TIM2", "TIM3e", "TIM3", "TVMe", "TVM", 
                                          "SYM", "GTR")
  if(attr(data, "type")=="AA") type <- .aamodels   
  
  if( (length(model)==1) && model == "all") model <- type
  model <- match.arg(model, type, TRUE)
  
  env <- new.env()
  assign("data", data, envir=env)
  
  if (is.null(tree)) 
    tree <- NJ(dist.hamming(data))
  else{
    if(length(tree$tip.label) > 3) tree <- nnls.phylo(tree, dist.ml(data)) 
    # may need something faster for trees > 500 taxa  
  }
  trace <- control$trace
  control$trace <- trace - 1
  fit <- pml(tree, data)
  fit <- optim.pml(fit, control = control)
  l <- length(model)
  if(attr(fit$data, "type")=="DNA")FREQ <- FALSE    
  n <- 1L + sum(I + G + (G & I) + FREQ + (FREQ & I) + (FREQ & G) + 
                  (FREQ & G & I))
  nseq <- sum(attr(data, "weight"))
  
  
  fitPar <- function(model, fit, G, I, k, FREQ) {
    m <- 1
    res <- matrix(NA, n, 6)
    res <- as.data.frame(res)
    colnames(res) <- c("Model", "df", "logLik", "AIC", "AICc", "BIC")
    data.frame(c("Model", "df", "logLik", "AIC", "AICc", "BIC"))
    calls <- vector("list", n)
    trees <- vector("list", n)
    fittmp <- optim.pml(fit, model = model, control = control)
    res[m, 1] <- model
    res[m, 2] <- fittmp$df
    res[m, 3] <- fittmp$logLik
    res[m, 4] <- AIC(fittmp)
    res[m, 5] <- AICc(fittmp)
    res[m, 6] <- AIC(fittmp, k = log(nseq))
    calls[[m]] <- fittmp$call
    
    trees[[m]] <- fittmp$tree
    m <- m + 1
    if (I) {
      if(trace>0)print(paste0(model, "+I"))
      fitI <- optim.pml(fittmp, model = model, optInv = TRUE, 
                        control = control)
      res[m, 1] <- paste0(model, "+I")
      res[m, 2] <- fitI$df
      res[m, 3] <- fitI$logLik
      res[m, 4] <- AIC(fitI)
      res[m, 5] <- AICc(fitI)
      res[m, 6] <- AIC(fitI, k = log(nseq))
      calls[[m]] <- fitI$call
      trees[[m]] <- fitI$tree
      m <- m + 1
    }
    if (G) {
      if(trace>0)print(paste0(model, "+G"))
      fitG <- update(fittmp, k = k)
      fitG <- optim.pml(fitG, model = model, optGamma = TRUE, 
                        control = control)
      res[m, 1] <- paste0(model, "+G")
      res[m, 2] <- fitG$df
      res[m, 3] <- fitG$logLik
      res[m, 4] <- AIC(fitG)
      res[m, 5] <- AICc(fitG)
      res[m, 6] <- AIC(fitG, k = log(nseq))
      calls[[m]] <- fitG$call
      trees[[m]] <- fitG$tree
      m <- m + 1
    }
    if (G & I) {
      if(trace>0)print(paste0(model, "+G+I"))
      fitGI <- update(fitI, k = k)
      fitGI <- optim.pml(fitGI, model = model, optGamma = TRUE, 
                         optInv = TRUE, control = control)
      res[m, 1] <- paste0(model, "+G+I")
      res[m, 2] <- fitGI$df
      res[m, 3] <- fitGI$logLik
      res[m, 4] <- AIC(fitGI)
      res[m, 5] <- AICc(fitGI)
      res[m, 6] <- AIC(fitGI, k = log(nseq))
      calls[[m]] <- fitGI$call
      trees[[m]] <- fitGI$tree
      m <- m + 1
    }
    if (FREQ) {
      if(trace>0)print(paste0(model, "+F"))
      fitF <- optim.pml(fittmp, model = model, optBf = TRUE, 
                        control = control)
      res[m, 1] <- paste0(model, "+F")
      res[m, 2] <- fitF$df
      res[m, 3] <- fitF$logLik
      res[m, 4] <- AIC(fitF)
      res[m, 5] <- AICc(fitF)
      res[m, 6] <- AIC(fitF, k = log(nseq))
      calls[[m]] <- fitF$call
      trees[[m]] <- fitF$tree
      m <- m + 1
    }
    if (FREQ & I) {
      if(trace>0)print(paste0(model, "+I+F"))
      fitIF <- update(fitF, inv = fitI$inv)
      fitIF <- optim.pml(fitIF, model=model, optBf = TRUE, optInv = TRUE,
                         control = control)
      res[m, 1] <- paste0(model, "+I+F")
      res[m, 2] <- fitIF$df
      res[m, 3] <- fitIF$logLik
      res[m, 4] <- AIC(fitIF)
      res[m, 5] <- AICc(fitIF)
      res[m, 6] <- AIC(fitIF, k = log(nseq))
      calls[[m]] <- fitIF$call
      trees[[m]] <- fitIF$tree
      m <- m + 1
    }
    if (FREQ & G) {
      if(trace>0)print(paste0(model, "+G+F"))
      fitGF <- update(fitF, k=k, shape=fitG$shape)
      fitGF <- optim.pml(fitGF, model = model, optBf = TRUE, 
                         optGamma = TRUE, control = control)
      res[m, 1] <- paste0(model, "+G+F")
      res[m, 2] <- fitGF$df
      res[m, 3] <- fitGF$logLik
      res[m, 4] <- AIC(fitGF)
      res[m, 5] <- AICc(fitGF)
      res[m, 6] <- AIC(fitGF, k = log(nseq))
      calls[[m]] <- fitGF$call
      trees[[m]] <- fitGF$tree
      m <- m + 1
    }
    if (FREQ & G & I) {
      if(trace>0)print(paste0(model, "+G+I+F"))
      fitGIF <- update(fitIF, k=k)
      fitGIF <- optim.pml(fitGIF, model = model, optBf = TRUE, 
                          optInv = TRUE, optGamma = TRUE, control = control)
      res[m, 1] <- paste0(model, "+G+I+F")
      res[m, 2] <- fitGIF$df
      res[m, 3] <- fitGIF$logLik
      res[m, 4] <- AIC(fitGIF)
      res[m, 5] <- AICc(fitGIF)
      res[m, 6] <- AIC(fitGIF, k = log(nseq))
      calls[[m]] <- fitGIF$call
      trees[[m]] <- fitGIF$tree
      m <- m + 1
    }
    list(res, trees, calls)
  }
  eval.success <- FALSE
  if (!eval.success & multicore) {
    # !require(parallel) ||         
    #        if (.Platform$GUI != "X11") {
    #            warning("package 'parallel' not found or GUI is used, \n      analysis is performed in serial")
    #       }
    #        else {
    RES <- mclapply(model, fitPar, fit, G, I, k, FREQ, mc.cores=mc.cores)
    eval.success <- TRUE
    #        }
  }
  if (!eval.success) 
    RES <- lapply(model, fitPar, fit, G, I, k, FREQ)
  RESULT <- matrix(NA, n * l, 8)
  RESULT <- as.data.frame(RESULT)
  colnames(RESULT) <- c("Model", "df", "logLik", "AIC", "AICw", "AICc", 
                        "AICcw", "BIC")
  
  for (i in 1:l) RESULT[((i - 1) * n + 1):(n * i), c(1,2,3,4,6,8)] <- RES[[i]][[1]]
  RESULT[,5] <- aic.weights(RESULT[,4])
  RESULT[,7] <- aic.weights(RESULT[,6])
  for(i in 1:l){
    for(j in 1:n){
      mo <- RES[[i]][[1]][j,1]
      tname <- paste0("tree_", mo)
      tmpmod <- RES[[i]][[3]][[j]]
      tmpmod["tree"] <- call(tname)
      if(!is.null(tmpmod[["k"]]))tmpmod["k"] <- k
      if(attr(data, "type")=="AA") tmpmod["model"] <- RES[[i]][[1]][1,1]          
      assign(tname, RES[[i]][[2]][[j]], envir=env)
      assign(mo, tmpmod, envir=env) 
    }
  }
  attr(RESULT, "env") <- env 
  RESULT
}
tidy.modelTest <- function(x){
  env <- attr(x, "env")
  l <- nrow(x)
  k <- rep(1L, l)
  shape <- rep(NA_real_, l)
  inv <- rep(0, l)
  for(i in seq_len(l)){
    tmp <- get(x$Model[i], env)
    if(!is.null(tmp[["k"]]))k[i] <- tmp[["k"]]
    if(!is.null(tmp[["shape"]]))shape[i] <- tmp[["shape"]]
    if(!is.null(tmp[["inv"]]))inv[i] <- tmp[["inv"]]
  }
  data.frame(Model = x$Model, k=k, shape=shape, inv=inv)
}
mt <- modelTest(dat)
env <- attr(mt, "env")
ls(env=env)
mt
min(mt$AIC)
model <- write.csv(mt, file = "model.csv")
#file.copy("/home/tsang/Documents/model.csv", "/home/tsang/Desktop")
##--Chosing model with value of min AIC 
##--It is gonna be respective model you look on table of modeltest
##--When you finish choosing of optimization model 
##--Continue copy model and run tree
##--Try to last step by hand and rewrite script
##--Accessing to Documents file by open computer an entrance to C:/Users/admin/Documents 
##--Click double script file "tree-by-hand.r" for your rewrite model purpose 
##--DO NOT CLOSE R-STUDIO BECAUSE THIS IS THE CONTINUE STEP


