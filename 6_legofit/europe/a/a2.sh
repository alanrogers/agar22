# Shell script to do the same job as a2.slr. Run from the bash command
# line like this:
#
# . a2.sh

lgofile=a.lgo
ifile=../data.opf
ofile=a2.legofit
efile=a2.err

(time legofit -1 -d 0 --tol 3e-6 -S 100 ${lgofile} ${ifile} \
  --stateIn a1.state \
  --stateIn a1boot0.state \
  --stateIn a1boot1.state \
  --stateIn a1boot2.state \
  --stateIn a1boot3.state \
  --stateIn a1boot4.state \
  --stateIn a1boot5.state \
  --stateIn a1boot6.state \
  --stateIn a1boot7.state \
  --stateIn a1boot8.state \
  --stateIn a1boot9.state) 1>${ofile} 2>${efile}
