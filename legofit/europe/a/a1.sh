# Shell script to do the same job as a1.slr. Run from the bash command
# line like this:
#
# . a1.sh

lgofile=a.lgo       # model
ifile=../data.opf   # input data
stateout=a1.state   # output state
ofile=a1.legofit    # main output
efile=a1.err        # error output

(time legofit -1 -d 0 --stateOut ${stateout} --tol 3e-6 \
  -S 100 ${lgofile} ${ifile}) 1>${ofile} 2>${efile}
