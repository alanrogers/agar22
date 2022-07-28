# Model ac

This model has the following episodes of gene flow: N->Y, XY->N.

To launch the pipeline:

    . pipeline.sh

## Timings

time-real and time-user were generated as follows:

    grep real *.err | awk '{print $2}' | tr "ms" " " |
        awk '{x += $1 + $2/60} END {print x}' > time-real
    grep user *.err | awk '{print $2}' | tr "ms" " " |
        awk '{x += $1 + $2/60} END {print x}' > time-user

Each file lists the number of minutes taken by the entire
analysis. Time-real measures elapsed time, time-user measures cpu time
excluding system calls.
