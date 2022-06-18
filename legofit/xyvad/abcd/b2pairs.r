library(ggplot2)
library(tidyr)
# Adjust text size. Default is 11
mytheme = theme_get()
mytheme$text$size = 20
theme_set(mytheme)

wide <- read.table("b2.flat", header=T)

# parameter names
parnames <- c("mN","mS","mXY","mSND",
              "Txynds","Tnd","Txy","Tav","Ta","Tv","Td",
              "twoNxynd","twoNnd","twoNxy","twoNav","twoNn","twoNs")

wide <- wide[,parnames]

# parameter labels
lbl <- expression("m"[alpha], "m"[beta], "m"[gamma], "m"[delta],
    "T"["XYNDS"],"T"["ND"], "T"["XY"],"T"["AV"],"T"["A"], "T"["V"],"T"["D"],
    "2N"["XYND"],"2N"["ND"],"2N"["XY"],"2N"["AV"],"2N"["N"],"2N"["S"])

pdf("b2pairs.pdf")
pairs(wide, labels=lbl)
dev.off()
