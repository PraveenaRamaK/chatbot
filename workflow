echo "$data" | grep -o 'maxpar_[0-9]=\(.*\|NO PARTITIONS\)'

echo "$data" | grep -oE 'maxpar_[0-9]=(NO PARTITIONS|[0-9]{4}-[0-9]{2}-[0-9]{2})'

echo "$data" | grep -o 'maxpar_[0-9]=[^[:space:]]*'
