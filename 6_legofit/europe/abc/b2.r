library(ggplot2)
df <- read.table("w2.flat", header=TRUE)
df <- df[c("mXY", "mN", "mS",
           "Txy","Tnd", "Tav", "Ta", "Tv", "Td", "Txynds",
           "twoNxy", "twoNxynd", "twoNnd", "twoNav", "twoNn")]

# norm-2 condition number
kappa(cor(df))

# Adjust text size. Default is 11
mytheme = theme_get()
mytheme$text$size = 20
theme_set(mytheme)

pairs(df, labels=expression("m"["XY"], "m"["N"], "m"["S"],
    "T"["XY"], "T"["ND"], "T"["AV"], "T"["A"], "T"["V"], "T"["D"],
    "T"["XYNDS"],
    "2N"["XY"], "2N"["XYND"], "2N"["ND"], "2N"["AV"], "2N"["N"]))
#pdf("xyvad-w2-pairs.pdf")
#pairs(df, labels=expression("m"["XY"], "m"["N"], "m"["S"],
#    "T"["XY"], "T"["ND"], "T"["AV"], "T"["A"], "T"["V"], "T"["D"],
#    "T"["XYNDS"],
#    "2N"["XY"], "2N"["XYND"], "2N"["ND"], "2N"["AV"], "2N"["N"]))
#dev.off()

df$Txynds <- df$Txynds*29/1e6
ggplot(df, aes(x=mS, y=Txynds)) +
    geom_point(shape=1, size=2) +
    geom_smooth(method="lm",se=F) +
    xlab(expression("m"["S"])) +
    ylab(expression(paste("T"["XYNDS"], " (mya)")))

ggsave("xyvad-w2-Txynds.pdf")
