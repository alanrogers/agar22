# Shell script to do the same job as a2.slr. Run from the bash command
# line like this:
#
# . a2.sh

lgofile=a.lgo
ifile=../data.opf
ofile=a2.legofit
efile=a2.err

(time legofit -1 -d 0 --tol 3e-6 -S 5000 ${lgofile} ${ifile} \
  --stateIn a1.state \
  --stateIn a1boot0.state \
  --stateIn a1boot1.state \
  --stateIn a1boot10.state \
  --stateIn a1boot11.state \
  --stateIn a1boot12.state \
  --stateIn a1boot13.state \
  --stateIn a1boot14.state \
  --stateIn a1boot15.state \
  --stateIn a1boot16.state \
  --stateIn a1boot17.state \
  --stateIn a1boot18.state \
  --stateIn a1boot19.state \
  --stateIn a1boot2.state \
  --stateIn a1boot20.state \
  --stateIn a1boot21.state \
  --stateIn a1boot22.state \
  --stateIn a1boot23.state \
  --stateIn a1boot24.state \
  --stateIn a1boot25.state \
  --stateIn a1boot26.state \
  --stateIn a1boot27.state \
  --stateIn a1boot28.state \
  --stateIn a1boot29.state \
  --stateIn a1boot3.state \
  --stateIn a1boot30.state \
  --stateIn a1boot31.state \
  --stateIn a1boot32.state \
  --stateIn a1boot33.state \
  --stateIn a1boot34.state \
  --stateIn a1boot35.state \
  --stateIn a1boot36.state \
  --stateIn a1boot37.state \
  --stateIn a1boot38.state \
  --stateIn a1boot39.state \
  --stateIn a1boot4.state \
  --stateIn a1boot40.state \
  --stateIn a1boot41.state \
  --stateIn a1boot42.state \
  --stateIn a1boot43.state \
  --stateIn a1boot44.state \
  --stateIn a1boot45.state \
  --stateIn a1boot46.state \
  --stateIn a1boot47.state \
  --stateIn a1boot48.state \
  --stateIn a1boot49.state \
  --stateIn a1boot5.state \
  --stateIn a1boot6.state \
  --stateIn a1boot7.state \
  --stateIn a1boot8.state \
  --stateIn a1boot9.state) 1>${ofile} 2>${efile}