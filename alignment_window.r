#####QUANG-SANG-Writer-####################
#################################
######Alignment###############
options(repos = c(CRAN = "http://cran.rstudio.com",CRAN="http://cran.us.r-project.org"))
#source("https://bioconductor.org/biocLite.R")
rm(list = ls())
if (!require("DECIPHER")) {
  biocLite("DECIPHER")
  library(DECIPHER)
}
#setwd("/home/tsang/Desktop/")
seqs <- readDNAStringSet(file.choose())
#setwd("/home/tsang/Documents/")
seqs <- OrientNucleotides(seqs)##oriental right reverse sequence
aligned <- AlignSeqs(seqs)
#BrowseSeqs(aligned, highlight=0)
writeXStringSet(aligned,file = "sequence_alignment.fasta")
#file.copy("/home/tsang/Documents/sequence_alignment.fasta","/home/tsang/Desktop")
#--File "sequence_alignment.fas" has already saved in desktop
#--You can open and look for a while 
#--then close for next step "processing_alignment"
#--You try to type source("processing_alignment.r") to executed command
####END-ALIGNMENT##################
