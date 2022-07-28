setwd("/your/working/directory/")
infile <- "test_AP_11"
colours <- c("#EE6677", "#CCBB44", "#4477AA")

options(stringsAsFactors=F)

likelihoods <- read.table(paste(infile, ".fb.tsv", sep=""), header=T)
split.cols <- unlist(strsplit(colnames(likelihoods)[-(1:4)], split="...", fixed=T))
inds <- unique(split.cols[seq(1,length(split.cols),3)])
ancs <- unique(split.cols[seq(3,length(split.cols),3)])

LA.calls <- read.table(paste(infile, ".msp.tsv", sep=""))
colnames(LA.calls) <- c("chr","start.bp","end.bp","start.g","end.g","n.snps",paste(rep(inds, each=2), 1:2, sep="."))

# Plot karyogram
for (ind in inds) {
  chrs <- unique(as.numeric(gsub("chr", "", as.character(LA.calls$chr))))
  plot(1, 1, xlim=c(min(LA.calls$start.bp)-1e4, max(LA.calls$end.bp)+1e4), ylim=range(c(chrs-length(chrs)*0.2,chrs+length(chrs)*0.2)), ann=F, type="n", yaxt="n")
  axis(2, at=chrs, las=2)
  title(main=ind)
  for (chr in chrs) {
    for (hap in 1:2) {
      condensed.haps <- as.data.frame(matrix(nrow=0, ncol=4))
      dat <- as.data.frame(LA.calls[,c(1:3,match(paste(ind,hap,sep="."), colnames(LA.calls)))]);dat <- dat[dat$chr==paste("chr",chr,sep=""),]
      switchpoints <- which(diff(dat[,4]) != 0)
      for (i in 1:(1+length(switchpoints))) {
        if (i == 1) {
          chunk.start <- 1
          chunk.end <- switchpoints[i]
        } else if (i == (1+length(switchpoints))) {
          chunk.start <- switchpoints[i-1]+1
          chunk.end <- nrow(dat)
        } else {
          chunk.start <- switchpoints[i-1]+1
          chunk.end <- switchpoints[i]
        }
        condensed.haps <- rbind(condensed.haps, c(chr, dat$start.bp[chunk.start], dat$end.bp[chunk.end], unique(dat[chunk.start:chunk.end,4])))
      }
      colnames(condensed.haps) <- c("chr", "start", "end", "anc")
      for (i in 1:nrow(condensed.haps)) {
        CHR <- condensed.haps[i,"chr"]
        y1 <- c(CHR-0.1, CHR, CHR+0.1)[hap]
        y2 <- c(CHR-0.1, CHR, CHR+0.1)[hap+1]
        chunk.start <- condensed.haps[i,"start"]
        chunk.end <- condensed.haps[i,"end"]
        COL <- colours[condensed.haps[i,"anc"]+1]
        rect(xleft=chunk.start, xright=chunk.end, ybottom=y1, ytop=y2, density = NULL, angle = 45, col=COL, border=NA)
      }
      rect(xleft=min(dat$start.bp), xright=max(dat$end.bp), ybottom=y1, ytop=y2, density = NULL, angle = 45)
    }
  }
}

