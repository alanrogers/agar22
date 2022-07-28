#!/bin/bash

# Remove rare variants (carried by less than 5% of entire sample)
plink --vcf ${1} --maf 0.05 --make-bed --out ${2}_maf0.05

# Give variants unique names based on base pair location
awk '{print $1 "\t" $4 "\t" $3 "\t" $4 "\t" $5 "\t" $6}' ${2}_maf0.05.bim > ${2}.bim.tmp
mv ${2}.bim.tmp ${2}_maf0.05.bim

# Give sample unique names
awk '{print $1, $1"_"$2, $3, $4, $5, $6}' ${2}_maf0.05.fam > ${2}.fam.tmp
mv ${2}.fam.tmp ${2}_maf0.05.fam

# Thin for linkage disequilibrium - within 10kb window (sliding 20 SNPs at a time), removes SNPs with an r2 of 0.3 or greater
plink --bfile ${2}_maf0.05 --indep-pairwise 10kb 20 0.3 --out $2
plink --bfile ${2}_maf0.05 --exclude ${2}.prune.out --make-bed --out ${2}_maf0.05_LDpruned

# Run ADMIXTURE
for K in `seq 2 5`;do
	admixture ${2}_maf0.05_LDpruned.bed $K --seed $RANDOM | tee ${2}.${K}.out
	for ext in Q P;do
		mv ${2}_maf0.05_LDpruned.${K}.${ext} ${2}.${K}.${ext}
	done
  	# Extract info from the run
	SEED=`grep seed ${2}.${K}.out | cut -f 3 -d ' '`
	LLIKE=`grep ^Log ${2}.${K}.out | cut -f 2 -d ' '`
	CVE=`grep CV ${2}.${K}.out | cut -f 4 -d ' '`
	if [ $K -eq 2 ];then
		echo $K $SEED $LLIKE $CVE > ${2}.run_stats.txt
	else
		echo $K $SEED $LLIKE $CVE >> ${2}.run_stats.txt
	fi
done

