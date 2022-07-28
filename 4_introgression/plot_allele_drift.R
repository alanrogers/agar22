plot.allele.drift <- function(f0=0.5, Ne=1000, gens=100, n_runs=1, bin_size=0.05) {
  # Set up data frame
  # Generate data
  sim.allele <- function(x, f0, Ne, gens) {
    A <- c(rep(1, Ne*f0), rep(0, Ne*(1-f0)))
    frq <- rep(NA, gens+1)
    frq[1] <- f0
    for (i in 2:length(frq)) {
      A <- sample(A, replace=T)
      frq[i] <- mean(A)
    }
    return(frq)
  }
  dat <- as.data.frame(t(sapply(X=1:n_runs, FUN=sim.allele, f0=f0, Ne=Ne, gens=gens)))
  # Plot data
  par(mfrow=c(1,2))
  plot(x=c(0, gens+1), y=c(0,1), type="n", xlab="Generation", ylab="Allele Frequency", las=1)
  mtext(paste0("Starting allele freq = ", f0, ", Ne = ", Ne), side=3, line=-2.25, outer=T)
  mtext(paste0(gens, " generations, ", n_runs, " iterations"), side=3, line=-3.25, outer=T)
  plot.runs <- function(n, dat, gens) {
    points(x=gens, y=dat[n,], type="l")
  }
  sapply(X=1:n_runs, FUN=plot.runs, dat=dat, gens=0:gens)
  hist(dat[,gens+1], breaks=seq(0, 1, bin_size), freq=T, xlab="Final Allele Frequency", ylab="Proportion of Runs", main="")
  abline(v=f0, lwd=2, lty=2, col="red")
}
