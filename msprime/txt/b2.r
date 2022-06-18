# File b2.r: This script reads file "b2.flat", which contains
# parameter estimates from several sets of simulated data. It then
# makes a 1-dimensional scatter plot for each parameter, which
# includes the estimate from each simulation replicate along with the
# true parameter value, as specified in the input to msprime. The true
# parameter values are hard coded into this file, rather than being
# read as input.

library(ggplot2)
library(cowplot)
library(tidyr)

# Adjust text size. Default is 11
mytheme = theme_get()
mytheme$text$size = 18
theme_set(mytheme)

# Input file
wide <- read.table("b2.flat", header=T)

# parameter names
parnames <- c("mAlpha", "mEpsilon", "Txy", "Tnd", "Ta", "Td",
              "twoNxynd", "twoNxy", "twoNnd", "twoNn", "twoNd")

# Subset data, keeping only the parameters we wish to plot.
wide <- wide[,parnames]

# Parameter labels, using R's "expression" syntax to make subscripts.
lbl <- expression("m"[alpha], "m"[epsilon], "T"["XY"], "T"["ND"],
    "T"["A"], "T"["D"],
    "2N"["XYND"], "2N"["XY"], "2N"["ND"], "2N"["N"], "2N"["D"])

# Make graph of migration parameters.
mpar <- c("mAlpha", "mEpsilon")
mdat <- subset(wide, select=mpar)

## Create two new parameters
mdat$msum <- mdat$mAlpha + mdat$mEpsilon
mdat$mdif <- mdat$mAlpha - mdat$mEpsilon

## Labels of migration parameters
mlbl <- expression("m"[alpha], "m"[epsilon], "m"[alpha]+"m"[epsilon],
                   "m"[alpha]-"m"[epsilon])

## Convert "wide" data format to "long".
mdat <- gather(mdat, par, value, mAlpha, mEpsilon, msum, mdif)

## Create column of true parameter values.
mdat$tru <- rep(NA, nrow(mdat))
mdat$tru[mdat$par == "mAlpha"] <- 0.05
mdat$tru[mdat$par == "mEpsilon"] <- 0.025
mdat$tru[mdat$par == "msum"] <- 0.075
mdat$tru[mdat$par == "mdif"] <- 0.025
mpar <- c("mAlpha", "mEpsilon", "msum", "mdif")

## This controls the order in which parameters appear on the graph.
mdat$par <- ordered(mdat$par, levels=rev(mpar))

## Plot migration rate
mplt <- ggplot(mdat, aes(value, par)) +
    xlab("Admixture Fraction") +
    theme(aspect.ratio=0.2,
          axis.title.y = element_blank()) +
    scale_x_continuous(limits=c(-0.005,0.08)) +
    scale_y_discrete(labels=rev(mlbl)) +
    geom_jitter(height=0.2, width=0, shape=1, alpha=0.5, size=4, color="blue") +
    geom_point(mapping=aes(tru, par), shape=4, size=4, color="red") +
    ggtitle("Deterministic algorithm")

# Make graph of time parameters
tpar <- c("Txy", "Tnd", "Ta", "Td")
tlbl <- expression("T"["XY"], "T"["ND"], "T"["A"], "T"["D"])
tdat <- subset(wide, select=tpar)
tdat <- gather(tdat, par,value)
tdat$tru <- rep(NA, nrow(tdat))
tdat$tru[tdat$par == "Txy"] <- 3788
tdat$tru[tdat$par == "Tnd"] <- 15000
tdat$tru[tdat$par == "Ta"] <- 1760
tdat$tru[tdat$par == "Td"] <- 1734
tdat$par <- ordered(tdat$par, levels=tpar)

tplt <- ggplot(tdat, aes(29*value/1000, par)) +
    xlab("Thousands of Years") +
    theme(aspect.ratio=0.2,
          axis.title.y = element_blank()) +
    scale_y_discrete(labels=tlbl) +
    geom_jitter(height=0.2, width=0, shape=1, alpha=0.5, size=4, color="blue") +
    geom_point(mapping=aes(29*tru/1000, par), shape=4, size=4, color="red")

# Make graph of population-size parameters
npar <- c("twoNxynd", "twoNxy", "twoNnd", "twoNn", "twoNd")
nlbl <- expression("2N"["XYND"], "2N"["XY"], "2N"["ND"], "2N"["N"],
    "2N"["D"])
ndat <- subset(wide, select=npar)
ndat <- gather(ndat, par,value)
ndat$tru <- rep(NA, nrow(ndat))
ndat$tru[ndat$par == "twoNxynd"] <- 64964.1
ndat$tru[ndat$par == "twoNxy"] <- 44869.2
ndat$tru[ndat$par == "twoNnd"] <- 5000.0
ndat$tru[ndat$par == "twoNn"] <- 9756.8
ndat$tru[ndat$par == "twoNd"] <- 5000
ndat$par <- ordered(ndat$par, levels=npar)

nplt <- ggplot(ndat, aes(value, par)) +
    xlab("Haploid Population Size (2N)") +
    theme(aspect.ratio=0.3,
          axis.title.y = element_blank()) +
    scale_y_discrete(labels=nlbl) +
    geom_jitter(height=0.2, width=0, shape=1, alpha=0.5, size=4, color="blue") +
    geom_point(mapping=aes(tru, par), shape=4, size=4, color="red")

# Combine the 3 graphs into a single graph
plot_grid(mplt, tplt, nplt, align="hv", ncol=1)

# Save graph in pdf format.
ggsave("b2dot.pdf")
