#!/bin/bash
#$ -l mem_free=40G
#$ -l slt=8
#$ -cwd
#########

export PATH=/biosoftware/conda/bin:$PATH

samples=$SGE_O_HOME/rapeseed/reads/joined/samples #set the bam directory
bam=$SGE_O_HOME/rapeseed/reads/aligned/samples
output_dir=$SGE_O_HOME/rapeseed/variants/samples #set the output directory
ref=$SGE_O_HOME/rapeseed/ref

cd $bam

sample_names=( $(find . | sed 's/.\///' | grep -oh "\w*_rn_sorted.bam\w*" | sort | uniq) )

bamname=${sample_names[$SGE_TASK_ID]}

echo $bamname

$SGE_O_HOME/tools/gatk-4.1.0.0/gatk --java-options "-Xmx36G" HaplotypeCaller \
				--emit-ref-confidence GVCF \
				-R $ref/Bna_2.0.fna \
				-I $bam/$bamname \
				-O $output_dir/$bamname\.g.vcf

# changing name after vcf creation: rename "_rn_sorted.bam" "" *
# There was a mistake made by me:
# --dbSNP argument should have been added at this step 
# As a result I've got the SNPs without IDs
#sample_names=( $('sed $samples/samples.tab | sort | uniq') ) #collect the sample names in  variable
