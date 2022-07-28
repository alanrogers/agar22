#!/bin/bash

# Slurm pipeline.  sbatch returns a string of form "Submitted batch
# job 123456". We only want the last word in this string. The sbatch
# steps below initially set a variable equal to the entire
# string. Then we extract the last word with a command like j1=${j1##*
# }. The syntax here is obscure to me but seems to work.

export SBATCH_ACCOUNT=rogersa
export SBATCH_PARTITION=notchpeak

# Stage 1 of analysis.
j1=$(sbatch a1.slr)
j2=$(sbatch --array=0-49 a1boot.slr)
j1=${j1##* }
j2=${j2##* }

# Stage 2 of analysis.
j3=$(sbatch --dependency=afterok:$j1:$j2 a2.slr)
j4=$(sbatch --dependency=afterok:$j1:$j2 --array=0-49 a2boot.slr)
j3=${j3##* }
j4=${j4##* }

# Rewrite .lgo file in terms of principal components. This makes
# file b.lgo.
j5=$(sbatch --dependency=afterok:$j3:$j4 pclgo.slr)
j5=${j5##* }

# Stage 1 for model b
j6=$(sbatch --dependency=afterok:$j5 b1.slr)
j7=$(sbatch --dependency=afterok:$j5 --array=0-49 b1boot.slr)
j6=${j6##* }
j7=${j7##* }

# Stage 2 for model b
sbatch --dependency=afterok:$j6:$j7 b2.slr
sbatch --dependency=afterok:$j6:$j7 --array=0-49 b2boot.slr

