# Shell script to do the same job as a1boot.slr. Run from the bash command
# line like this:
#
#     seq 0 49 | xargs -n 1 bash a1boot.sh
#
# Note: don't use -P (parallel mode) option of xargs, because legofit
# is already using all available cores.

lgofile=a.lgo                 # model
ifile=../boot/boot${1}.opf    # data
stateout=a1boot${1}.state     # output state
ofile=a1boot${1}.legofit      # main output 
efile=a1boot${1}.err          # error output

(time legofit -1 -d 0 --stateOut ${stateout} --tol 3e-6 \
  -S 100 ${lgofile} ${ifile}) 1>${ofile} 2>${efile}
