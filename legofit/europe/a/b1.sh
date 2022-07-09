# Shell script to do the same job as b1.slr. Run from the bash command
# line like this:
#
# . b1.sh

lgofile=b.lgo
ifile=../data.opf
stateout=b1.state
ofile=b1.legofit
efile=b1.err

(time legofit -1 -d 0 --stateOut ${stateout} --tol 3e-6 \
  -S 5000 ${lgofile} ${ifile}) 1>${ofile} 2>${efile}
