# Shell script to do the same job as a2boot.slr. Run from the bash command
# line like this:
#
#     seq 0 49 | xargs -n 1 bash a2boot.sh
#
# Note: don't use -P (parallel mode) option of xargs, because legofit
# is already using all available cores.

ifile=../boot/boot${1}.opf
lgofile=a.lgo
ofile=a2boot${1}.legofit
efile=a2boot${1}.err

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
