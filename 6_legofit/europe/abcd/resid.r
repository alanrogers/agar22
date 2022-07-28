library(ggplot2)
library(stringr)

real.datafile <- "../data.opf"
model <- "abcd"
stage="b2"

# Construct a script, which will be processed by the linux command
# "sed". The script has two commands separated by a semicolon. The
# first command (s/[#:]//g) deletes sharps and colons from the
# input. The second command (beginning with /SitePat/) tells sed to
# print lines from the one containing "SitePat" to the end of the
# file.
script <- "'s/[#:]//g; /SitePat/,$ p'"

# Return a data frame, the result of parsing a .legofit file
# to obtain site pattern frequencies
parselegofit <- function(fname) {
    # linux shell command.
    cmd <- paste("sed -n", script, fname)

    # Open a pipe that executes the shell command. read.table reads from
    # this pipe as though it were a file. Then close the pipe.
    p <- pipe(cmd, open="r")
    data <- read.table(p, header=T)
    close(p)

    # column names
    names(data) <- c("pat", "frq")

    # make "pat" an order vector so that the site patterns will
    # plot in the same order as the input file.
    data$pat <- ordered(data$pat, levels=rev(data$pat))

    # convert to relative frequencies
    data$frq <- data$frq / sum(data$frq)

    # get rid of colons in site pattern labels
    data$pat <- sapply(data$pat, str_replace_all, ":", "")

    return(data)
}

# Read observed and fitted site pattern frequencies and return a data frame
# with a row for each site pattern. The data frame has two columns: "pat" is
# the label of the site pattern and "frq" is its relative frequency.
getresid <- function(obsfname, lgofname) {
    obs <- read.table(obsfname, header=F)
    obs <- obs[,1:2]
    names(obs) <- c("pat", "frq")
    obs$frq <- obs$frq/sum(obs$frq)
    obs$pat <- sapply(obs$pat, str_replace_all, ":", "")

    df <- parselegofit(lgofname)
    if(!all(df$pat == obs$pat) ) {
        print(paste("Pattern label mismatch in files", obsfname,
                    "and", lgofname))
        stop
    }
    df$resid <- obs$frq - df$frq
    df <- df[,c("pat", "resid")]
    df$pat <- ordered(df$pat, levels=rev(df$pat))

    return(df)
}

# Adjust text size. Default is 11
mytheme = theme_get()
mytheme$text$size = 20
theme_set(mytheme)

# data frame for residuals from real data
real.legofit <- paste(stage, ".legofit", sep="")
obsres <- getresid(real.datafile, real.legofit)

# Data frame for residuals from bootstrap replicates
bootres <- data.frame(pat=vector("character", 0), resid=vector("numeric",0))

# read bootstrap replicates and concatenate into df
for(i in 0:49) {
    # file names
    curr.legofit <- paste(stage, "boot", i, ".legofit", sep="")
    curr.boot <- paste("../boot/boot", i, ".opf", sep="")
    res <- getresid(curr.boot, curr.legofit)

    if(!all(res$pat == obsres$pat) ) {
        print(paste("Pattern label mismatch in files", curr.legofit,
              "and", real.legofit))
        stop
    }

    # append to df
    bootres <- rbind(bootres, res)
}

ggplot(bootres, aes(resid, pat)) +
    ggtitle("Deterministic algorithm") +
    xlab("Observed Minus Fitted") + ylab("Site Pattern") +
    geom_vline(xintercept=0) +
    xlim(c(-0.002, 0.002)) +
    theme(aspect.ratio=1.5) +
    geom_jitter(height=0.2, width=0, color="blue", shape=1, size=2,
                alpha=0.25) +
    geom_point(data=obsres, shape=8, size=3, color="red")

outfile <- paste("xyvad", model, stage, "det", "resid.pdf", sep="-")
ggsave(outfile)
