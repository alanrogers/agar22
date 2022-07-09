# Shell script to do the same job as b2boot.slr. Run from the bash command
# line like this:
#
#     seq 0 49 | xargs -n 1 bash b2boot.sh
#
# Note: don't use -P (parallel mode) option of xargs, because legofit
# is already using all available cores.

ifile=../boot/boot${1}.opf
lgofile=b.lgo
ofile=b2boot${1}.legofit
efile=b2boot${1}.err

(time legofit -1 -d 0 --tol 3e-6 -S 5000 ${lgofile} ${ifile} \
  --stateIn b1.state \
  --stateIn b1boot0.state \
  --stateIn b1boot1.state \
  --stateIn b1boot10.state \
  --stateIn b1boot11.state \
  --stateIn b1boot12.state \
  --stateIn b1boot13.state \
  --stateIn b1boot14.state \
  --stateIn b1boot15.state \
  --stateIn b1boot16.state \
  --stateIn b1boot17.state \
  --stateIn b1boot18.state \
  --stateIn b1boot19.state \
  --stateIn b1boot2.state \
  --stateIn b1boot20.state \
  --stateIn b1boot21.state \
  --stateIn b1boot22.state \
  --stateIn b1boot23.state \
  --stateIn b1boot24.state \
  --stateIn b1boot25.state \
  --stateIn b1boot26.state \
  --stateIn b1boot27.state \
  --stateIn b1boot28.state \
  --stateIn b1boot29.state \
  --stateIn b1boot3.state \
  --stateIn b1boot30.state \
  --stateIn b1boot31.state \
  --stateIn b1boot32.state \
  --stateIn b1boot33.state \
  --stateIn b1boot34.state \
  --stateIn b1boot35.state \
  --stateIn b1boot36.state \
  --stateIn b1boot37.state \
  --stateIn b1boot38.state \
  --stateIn b1boot39.state \
  --stateIn b1boot4.state \
  --stateIn b1boot40.state \
  --stateIn b1boot41.state \
  --stateIn b1boot42.state \
  --stateIn b1boot43.state \
  --stateIn b1boot44.state \
  --stateIn b1boot45.state \
  --stateIn b1boot46.state \
  --stateIn b1boot47.state \
  --stateIn b1boot48.state \
  --stateIn b1boot49.state \
  --stateIn b1boot5.state \
  --stateIn b1boot6.state \
  --stateIn b1boot7.state \
  --stateIn b1boot8.state \
  --stateIn b1boot9.state) 1>${ofile} 2>${efile}
