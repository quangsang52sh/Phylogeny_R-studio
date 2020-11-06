#!/bin/bash
less -S Desktop/model.csv | tr ',' '\t'|tr '\t\t' '\t'|cut -f2,5| sort -k2|head -1 |cut -f1 > bestmodel
#bestmodel = "model+G+I"
less bestmodel |tr '"' ' '| sed 's/+/\t/g'|cut -f1 > model
less bestmodel | sed 's/+/"\t/g'|cut -f1 > model1
#model = model
#model1 = "model"
less model| awk '{print $0" <- get"}' > part1
paste part1 bestmodel| awk '{print $1" "$2" "$3" ("$4", env)"}' > part2
#Part2 = TIM2 <- get ("TIM2+I", env)
less model |awk '{print "your_model <- eval("$0", env=env)"}'> part3
#Part3 = your_model <- eval( TIM2, env=env)
echo "dm <- dist.ml(dat)nnntreeNJ <- NJ(dm)nnnfit <- pml(treeNJ, data=dat)nnnparsimony(treeNJ, dat)nnn" | sed 's/nnn/\n/g' > part4
#part4= dm <- dist.ml(dat)
#treeNJ <- NJ(dm)
#fit <- pml(treeNJ, data=dat)
#parsimony(treeNJ, dat)
cat part2 part3 part4 > part5
less model1| awk '{print "fit1 <- optim.pml(fit, model="$0", optInv=TRUE, optGamma=TRUE, rearrangement = "NNI", control = pml.control(trace = 0))"}' > part6
echo "bs <- bootstrap.pml(fit1, bs=1000, optNni=TRUE, control = pml.control(trace = 0))zzztree <- plotBS(midpoint(fit1+tree), bs, p = 50, type=_p_)"| sed 's/zzz/\n/g'|sed 's/+/$/g'|sed 's/_/"/g' > part7
#part6 = fit1 <- optim.pml(fit, model="TIM2", optInv=TRUE, optGamma=TRUE, rearrangement = , control = pml.control(trace = 0))
#part7==.... tree <-...
echo "write.tree(tree,+Yourtree.tre+)"| sed 's/+/"/g' > part8
#part8 = write.tree(tree,"Yourtree.tre")
#echo "file.copy(+/home/tsang/Documents/your_model+, +/home/tsang/Desktop+)"| sed 's/+/"/g' > part9
#part9 = your_model
#echo "file.copy(+/home/tsang/Documents/Yourtree.tre+, +/home/tsang/Desktop+)"| sed 's/+/"/g' > part10
#part10 = file.copy..........
cat part5 part6 part7 part8 > tree-by-hand.r
sudo rm part1 part2 part3 part4 part5 part6 part7 part8 model model1 bestmodel
cp -r tree-by-hand.r /home/tsang/R/ALL-Script-useful-R/
cat tree-by-hand.r|head -1 > /home/tsang/Desktop/model.txt
#sudo rm tree-by-hand.r


