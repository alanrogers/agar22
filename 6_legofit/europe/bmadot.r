library(ggplot2)
library(cowplot)

# Adjust text size. Default is 11
mytheme = theme_get()
mytheme$text$size = 20
theme_set(mytheme)

long <- read.table("all.bootci", header=T)
ndat <- droplevels(subset(long, par %in% c("twoNs", "twoNxynd","twoNxy",
                                           "twoNnd","twoNav","twoNn") ))
mdat <- droplevels(subset(long, par %in% c("mN","mXY", "mSND", "mS")))
tdat <- droplevels(subset(long, par %in% c("Txynds", "Txy", "Tnd", "Tav",
                                           "Ta", "Tv", "Td")))
mdat$par <- ordered(mdat$par,
                    levels=rev(c("mN", "mS", "mXY", "mSND")))
ndat$par <- ordered(ndat$par,
                    levels=rev(c("twoNs", "twoNxynd","twoNxy","twoNnd",
	 "twoNav","twoNn")))
tdat$par <- ordered(tdat$par,
                    levels=rev(c("Txynds", "Txy", "Tnd", "Tav", "Ta",
                    "Tv", "Td")))

nplt <- ggplot(ndat, aes(par, est/2, ymin=low/2, ymax=high/2)) +
    geom_pointrange(pch=1, size=1) +
    coord_flip() +
#    ylim(0, 20000) +
    ylab("Population Size") +
    scale_x_discrete(labels=rev(c(expression("N"["S"]),
                     expression("N"["XYND"]),
                     expression("N"["XY"]),
                     expression("N"["ND"]),
                     expression("N"["N"[0]]),
                     expression("N"["N"[1]])))) +
    theme(#aspect.ratio = 3/11,
          axis.title.y = element_blank(),
          panel.grid.minor = element_blank())

# ticks and labels
hunthouyr <- seq(1,31)
generations <- hunthouyr*1e5/29

tplt <- ggplot(tdat, aes(par, est, ymin=low, ymax=high)) +
    geom_pointrange(pch=1, size=1) +
    coord_flip() +
    ylab(expression("Million Years Ago")) +
    scale_y_continuous(trans='log10',
                       breaks = generations,
                       labels=c("0.1","","","","0.5","","","","","1",
                       "","","","","","","","","","2",
                       "","","","","","","","","","3","")) +
    scale_x_discrete(labels=rev(c(expression("T"["XYNDS"]),
                     expression("T"["XY"]),
                     expression("T"["ND"]),
                     expression("T"["N"[0]]),
                     expression("T"["A"]),
                     expression("T"["V"]),
                     expression("T"["D"])))) +
    theme(axis.title.y = element_blank(),
          legend.position="none",
          panel.grid.minor = element_blank())

mplt <- ggplot(mdat, aes(par, est, ymin=low, ymax=high)) +
    geom_pointrange(pch=1, size=1) +
    scale_y_continuous(limits=c(0, 0.05154061),
                       breaks=c(0, 0.02, 0.04)) +
    coord_flip() +
    ylab("Admixture Fraction") +
    scale_x_discrete(labels=rev(c(expression("m"[alpha]),
                     expression("m"[beta]),
                     expression("m"[gamma]),
                     expression("m"[delta]) ))) +
    theme(aspect.ratio = 0.2,
          axis.title.y = element_blank(),
          panel.grid.minor = element_blank())

plot_grid(mplt, tplt, nplt, ncol=1, align='v', axis='l',
    rel_widths=c(1,1,1))
ggsave("bmadot.pdf")

