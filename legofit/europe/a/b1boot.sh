# Shell script to do the same job as b1boot.slr. Run from the bash command
# line like this:
#
#     seq 0 49 | xargs -n 1 bash b1boot.sh
#
# Note: don't use -P (parallel mode) option of xargs, because legofit
# is already using all available cores.

lgofile=b.lgo                 # model
ifile=../boot/boot${1}.opf    # data
stateout=b1boot${1}.state     # output state
ofile=b1boot${1}.legofit      # main output 
efile=b1boot${1}.err          # error output

(time legofit -1 -d 0 --stateOut ${stateout} --tol 3e-6 \
     -S 5000 ${lgofile} ${ifile})  1>${ofile} 2>${efile}
