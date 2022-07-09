cmd="(grep ^# a.lgo;"
cmd+=" pclgo a.lgo a2.legofit a2boot*.legofit;"
cmd+=" grep -v ^# a.lgo | egrep -v \"\<free\>\")"
echo "# "$cmd > b.lgo
eval $cmd >> b.lgo
