# Model abcd

This model has the following episodes of gene flow: N->Y, S->D, XY->N,
and S->ND. Txynds is a free parameter. To launch the pipeline:

    . pipeline.sh

File fitted.lgo is like a.lgo, but all the free variable values have
been set equal to estimates from b2.legofit.

## Timings

time-real and time-user were generated as follows:

    grep real *.err | awk '{print $2}' | tr "ms" " " |
        awk '{x += $1 + $2/60} END {print x}' > time-real
    grep user *.err | awk '{print $2}' | tr "ms" " " |
        awk '{x += $1 + $2/60} END {print x}' > time-user

Each file lists the number of minutes taken by the entire
analysis. Time-real measures elapsed time, time-user measures cpu time
excluding system calls.
