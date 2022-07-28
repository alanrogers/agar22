# This script implements a scaled-down version of pipeline in
# bash. Rather than 50 bootstrap replicates, we're doing only 10. And
# each of the scripts called by this one does only 100 iterations of
# the optimizer.
#
# To run it from the bash command line, type
#
#     bash bash_pipeline.sh

# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG

# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT

# Stage 1 of analysis.
bash a1.sh
seq 0 9 | xargs -n 1 bash a1boot.sh

# Stage 2 of analysis.
bash a2.sh
seq 0 9 | xargs -n 1 bash a2boot.sh

# In this scaled-down analysis, we can't do the rest of the pipeline,
# because we don't have enough bootstrap replicates to do a principal
# components analysis. I have therefore commented out the rest of the
# pipeline. 

## Rewrite .lgo file in terms of principal components. This makes
## file b.lgo.
#bash pclgo.sh
#
## Stage 1 for model b
#bash b1.sh
#seq 0 9 | xargs -n 1 bash b1boot.sh
#
## Stage 2 for model b
#bash b2.sh
#seq 0 9 | xargs -n 1 bash b2boot.sh

