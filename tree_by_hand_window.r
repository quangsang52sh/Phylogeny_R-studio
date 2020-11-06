GTR <- get ("GTR+G+I", env) #fix here
your_model <- eval( GTR, env=env) #fix here
dm <- dist.ml(dat)
treeNJ <- NJ(dm)
fit <- pml(treeNJ, data=dat)
parsimony(treeNJ, dat)

fit1 <- optim.pml(fit, model="GTR", optInv=TRUE, optGamma=TRUE, rearrangement = , control = pml.control(trace = 0)) #fix here
bs <- bootstrap.pml(fit1, bs=1000, optNni=TRUE, control = pml.control(trace = 0))
tree <- plotBS(midpoint(fit1$tree), bs, p = 50, type="p")
write.tree(tree,"Yourtree.tre")
