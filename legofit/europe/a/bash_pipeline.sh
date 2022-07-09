# This script implements the full pipeline in bash, so that you can run it
# on a personal computer without using slurm.
#
# To run it from the bash command line, type
#
#     bash bash_pipeline.sh

# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG

# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

# Stage 1 of analysis.
bash a1.sh
seq 0 49 | xargs -n 1 bash a1boot.sh

# Stage 2 of analysis.
bash a2.sh
seq 0 49 | xargs -n 1 bash a2boot.sh

# Rewrite .lgo file in terms of principal components. This makes
# file b.lgo.
bash pclgo.sh

# Stage 1 for model b
bash b1.sh
seq 0 49 | xargs -n 1 bash b1boot.sh

# Stage 2 for model b
bash b2.sh
seq 0 49 | xargs -n 1 bash b2boot.sh

