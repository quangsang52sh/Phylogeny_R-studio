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
seqs <- readDNAStringSet("alignment.txt")
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
#####QUANG-SANG-Writer-####################
#################################
######Alignment###############
options(repos = c(CRAN = "http://cran.rstudio.com",CRAN="http://cran.us.r-project.org"))
#source("https://bioconductor.org/biocLite.R")
rm(list = ls())
if (!require("Biostrings")) {
  biocLite("Biostrings")
  library(Biostrings) 
}
if (!require("seqinr")) {
  biocLite("seqinr")
  library(seqinr) 
}
#setwd("/home/tsang/Desktop/")
virusaln <- read.alignment("sequence_alignment.fasta", format = "fasta")
#setwd("/home/tsang/Documents/")
cleanAlignment <- function(alignment, minpcnongap, minpcid)
{
  # make a copy of the alignment to store the new alignment in:
  newalignment <- alignment
  # find the number of sequences in the alignment
  numseqs <- alignment$nb
  # empty the alignment in "newalignment")
  for (j in 1:numseqs) { newalignment$seq[[j]] <- "" }
  # find the length of the alignment
  alignmentlen <- nchar(alignment$seq[[1]])
  # look at each column of the alignment in turn:
  for (i in 1:alignmentlen)
  {
    # see what percent of the letters in this column are non-gaps:
    nongap <- 0
    for (j in 1:numseqs)
    {
      seqj <- alignment$seq[[j]]
      letterij <- substr(seqj,i,i)
      if (letterij != "-") { nongap <- nongap + 1}
    }
    pcnongap <- (nongap*100)/numseqs
    # Only consider this column if at least minpcnongap % of the letters are not gaps:
    if (pcnongap >= minpcnongap)
    {
      # see what percent of the pairs of letters in this column are identical:
      numpairs <- 0; numid <- 0
      # find the letters in all of the sequences in this column:
      for (j in 1:(numseqs-1))
      {
        seqj <- alignment$seq[[j]]
        letterij <- substr(seqj,i,i)
        for (k in (j+1):numseqs)
        {
          seqk <- alignment$seq[[k]]
          letterkj <- substr(seqk,i,i)
          if (letterij != "-" && letterkj != "-")
          {
            numpairs <- numpairs + 1
            if (letterij == letterkj) { numid <- numid + 1}
          }
        }
      }
      pcid <- (numid*100)/(numpairs)
      # Only consider this column if at least %minpcid of the pairs of letters are identical:
      if (pcid >= minpcid)
      {
        for (j in 1:numseqs)
        {
          seqj <- alignment$seq[[j]]
          letterij <- substr(seqj,i,i)
          newalignmentj <- newalignment$seq[[j]]
          newalignmentj <- paste(newalignmentj,letterij,sep="")
          newalignment$seq[[j]] <- newalignmentj
        }
      }
    }
  }
  return(newalignment)
}
cleanedvirusaln <- cleanAlignment(virusaln, 20, 20)
write.fasta(cleanedvirusaln$seq, cleanedvirusaln$nam, file="processing_alignment.fasta")
#file.copy("/home/tsang/Documents/processing_alignment.fasta","/home/tsang/Desktop")
#--File "processing_alignment.fasta" has already saved in desktop
#--All the thing to do now that you just need to open file and then cut head and tail equally of sequence
#--Save file by Ctrl + S and close for next step which is "constructing tree"
#--Before constructing tree, you need to check model test optimization for your tree
#--Type source("model.r")
#########----------END-----------------########################
