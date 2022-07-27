#!/bin/bash

# Re-do allele frequency filtering, but using vcftools to preserve phase
vcftools --vcf ${1} --maf 0.01 --recode --out ${2}_maf0.01

# Add 'chr' to start of chromosome number in vcf file
awk '{if($0 !~ /^#/) print "chr"$0; else print $0}' ${2}_maf0.01.recode.vcf > ${2}_maf0.01.recode.vcf.TMP
mv ${2}_maf0.01.recode.vcf.TMP  ${2}_maf0.01.recode.vcf

# Designate samples from the three source populations to different reference panels
for POP in SP1 SP2 SP3;do
	for i in `seq 1 50`;do
		if [[ $i -eq 1 && $POP == "SP1" ]];then
			echo ${POP}_${i} > ref_panel.list
			echo ${POP}_${i}'\t'${POP} > ref_panel.map
		else
			echo ${POP}_${i} >> ref_panel.list
			echo ${POP}_${i}'\t'${POP} >> ref_panel.map
		fi
	done
done

# Make a list of the focal sample
echo ${3} > focal.list

# Split data into 'reference' and 'focal' sets
vcftools --vcf ${2}_maf0.01.recode.vcf --keep ref_panel.list --recode --out ${2}_ref_panel
vcftools --vcf ${2}_maf0.01.recode.vcf --keep focal.list --recode --out ${2}_focal

# Generate a fake recombination map
echo chr1'\t'0'\t'0 > recomb_map
echo chr1'\t'30000000'\t'30 >> recomb_map

# Run RFMix
rfmix -f ${2}_focal.recode.vcf \
      -r ${2}_ref_panel.recode.vcf \
      -m ref_panel.map \
      -g recomb_map \
      -o ${2}_${3} \
      -e 2 \
      --chromosome=chr1