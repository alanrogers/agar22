library(ggplot2)
library(cowplot)

# Adjust text size. Default is 11
mytheme = theme_get()
mytheme$text$size = 20
theme_set(mytheme)

# Read data
long <- read.table("a2.bootci", header=T)

# popsize data
ndat <- droplevels(subset(long, par %in% c("twoNxynd", "twoNnd", "twoNxy",
                                           "twoNav", "twoNn")))

# migration rate data
mdat <- droplevels(subset(long, par %in% c("mN")))

# time data
tdat <- droplevels(subset(long, par %in% c("Tnd", "Txy", "Tav", "Ta", "Tv",
                                           "Td")))

# order them as we want them to appear in the graph
ndat$par <- ordered(ndat$par,
                    levels=rev(c("twoNxynd", "twoNnd", "twoNxy",
                                           "twoNav", "twoNn")))
tdat$par <- ordered(tdat$par,
                    levels=rev(c("Tnd", "Txy", "Tav", "Ta", "Tv",
                                           "Td")))

# plot population size estimates
nplt  <- ggplot(ndat, aes(par, est/2, ymin=low/2, ymax=high/2)) +
    geom_pointrange(pch=1, size=1) +
    coord_flip() +
#    ylim(0, 20000) +
    ylab("Population Size") +
    scale_x_discrete(labels=rev(c(expression("N"["S"]),
                     expression("N"["XYND"]),
                     expression("N"["ND"]),
                     expression("N"["XY"]),
                     expression("N"["AV"]),
                     expression("N"["N"])))) +
    theme(axis.title.y = element_blank(),
          panel.grid.minor = element_blank())

# ticks and labels
hunthouyr <- seq(1,31)
generations <- hunthouyr*1e5/29

# plot time estimates
tplt <- ggplot(tdat, aes(par, est, ymin=low, ymax=high)) +
    geom_pointrange(pch=1, size=1) +
    coord_flip() +
    ylab(expression("Million Years Ago")) +
    scale_y_continuous(trans='log10',
                       breaks = generations,
                       labels=c("0.1","","","","0.5","","","","","1",
                       "","","","","","","","","","2",
                       "","","","","","","","","","3","")) +
    scale_x_discrete(labels=rev(c(expression("T"["ND"]),
                     expression("T"["XY"]),
                     expression("T"["AV"]),
                     expression("T"["A"]),
                     expression("T"["V"]),
                     expression("T"["D"])))) +
    theme(axis.title.y = element_blank(),
          legend.position="none",
          panel.grid.minor = element_blank())

mplt <- ggplot(mdat, aes(par, est, ymin=low, ymax=high)) +
    geom_pointrange(pch=1, size=1) +
    scale_y_continuous(limits=c(0, 0.04),
                       breaks=c(0, 0.02, 0.04)) +
    coord_flip() +
    ylab("Admixture Fraction") +
    scale_x_discrete(labels=rev(c(expression("m"[alpha])))) +
    theme(axis.title.y = element_blank(),
          panel.grid.minor = element_blank())

plot_grid(mplt, tplt, nplt, align="hv", ncol=1)
ggsave("a-det-dot.pdf")
