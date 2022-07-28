setwd("/your/working/directory/")
outfile <- "test"
options(stringsAsFactors=F)

# Load in the .fam file for sample names
fam <- read.table(paste0(outfile, "_maf0.05.fam"))
sample_size=nrow(fam)/4

# Make ADMIXTURE plots for Ks 2-5
for (K in 5:2) {
  Q.dat <- read.table(paste0(outfile, ".", K, ".Q"))
  rownames(Q.dat) <- fam[,2]
  barplot(height=as.matrix(t(Q.dat)), beside=F, col=c("#EE6677", "#CCBB44", "#4477AA", "#228833", "#BBBBBB"), border=NA, space=0.0001, xaxt="n")
  segments(x0=c(0, sample_size, sample_size*2, sample_size*3, sample_size*4, 0, 0), x1=c(0, sample_size, sample_size*2, sample_size*3, sample_size*4, sample_size*4, sample_size*4), y0=c(0, 0, 0, 0, 0, 0, 1), y1=c(1, 1, 1, 1, 1, 0, 1), lwd=3)
  axis(1, at=c(sample_size-sample_size/2, sample_size*2-sample_size/2, sample_size*3-sample_size/2, sample_size*4-sample_size/2) ,labels=c("SP1", "SP2", "SP3", "AP"))
}

# What were the estimated ancestry proportions for individuals in the admixed population?
K = 3
Q.dat <- read.table(paste0(outfile, ".", K, ".Q"))
rownames(Q.dat) <- fam[,2]
pops <- fam$V1
for (i in 1:K) {
  pop <- fam[fam$V2==rownames(Q.dat)[which.max(Q.dat[,i])],1]
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

# Report your result!
# https://forms.gle/h1R28Cw71MYTEA7m9
