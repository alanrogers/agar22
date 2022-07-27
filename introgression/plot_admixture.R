setwd("/Users/shyamie/Dropbox (Duke Bio_Ea)/Shyamie/Work/Presentations_and_Teaching/2022_AGAR/")
outfile <- "test"
options(stringsAsFactors=F)

# Load in the .fam file for sample names
fam <- read.table(paste0(outfile, "_maf0.02.fam"))
sample_size=20

# Make ADMIXTURE plots for Ks 2-5
for (K in 2:5) {
  Q.dat <- read.table(paste0(outfile, ".", K, ".Q"))
  rownames(Q.dat) <- c(paste0(fam[,1], "_", rep(1:sample_size, 4)))
  barplot(height=as.matrix(t(Q.dat)), beside=F, col=c("#228833", "#CCBB44", "#4477AA", "#EE6677", "#BBBBBB"), border=NA, space=0.0001, xaxt="n")
  segments(x0=c(0, sample_size, sample_size*2, sample_size*3, sample_size*4, 0, 0), x1=c(0, sample_size, sample_size*2, sample_size*3, sample_size*4, sample_size*4, sample_size*4), y0=c(0, 0, 0, 0, 0, 0, 1), y1=c(1, 1, 1, 1, 1, 0, 1), lwd=3)
  axis(1, at=c(sample_size-sample_size/2, sample_size*2-sample_size/2, sample_size*3-sample_size/2, sample_size*4-sample_size/2) ,labels=c("SP1", "SP2", "SP3", "AP"))
}

# What were the estimated ancestry proportions for individuals in the admixed population?
K = 3
Q.dat <- read.table(paste0(outfile, ".", K, ".Q"))
rownames(Q.dat) <- c(paste0(fam[,1], "_", rep(1:sample_size, 4)))
pops <- rep(c("SP1", "SP2", "SP3", "AP"), each=sample_size)
for (i in 1:K) {
  pop <- pops[which.max(Q.dat[,i])]
  avg.anc <- mean(Q.dat[pops=="AP",i])
  sd.anc <- sd(Q.dat[pops=="AP",i])
  if (i==1) {
    cat(paste0("Estimated ancestry composition for the admixed population:\n"))
  }
  cat(paste0("  * ", signif(avg.anc, 3)*100, "% (sd ", signif(sd.anc, 3)*100, "%) of the ancestry that is maximal in ", pop, "\n"))
}

# Which model has the lowest cross-validation error?
stats <- read.table(paste0(outfile, ".run_stats.txt"))
plot(stats$V1, stats$V3, xlab="K", ylab="cross-validation error", xaxt="n", pch=16)
axis(1, at=stats$V1, labels=stats$V1)
