#!/bin/bash
#$ -l mem_free=5G
#$ -l slt=8
#$ -cwd
##########################################################

#export PATH=$PATH:/usr/lib/
#export LD_LIBRARY_PATH=$SGE_O_HOME/../../lib64/
#export LIBRARY_PATH=$SGE_O_HOME/../../lib64/
reads=$SGE_O_HOME/path_to/reads/joined #set the reads directory
output_dir=$SGE_O_HOME/path_to/reads/aligned #set the output directory
ref=$SGE_O_HOME/path_to/ref 
bwa=$SGE_O_HOME/tools/bwa-0.7.17 #set the path to bwa
samtools=$SGE_O_HOME/tools/samtools-1.9 #set the samtools directory 
barcodes=$SGE_O_HOME/path_to/reads/ #set the directory with barcodes

sample_names=$(awk '{print $2}' $barcodes/barcodes.tsv | sort -u | sed -r '/^\s*$/d') #collect the sample names in  variable

#run alignment and sorting over set of fastq files

for name in $sample_names
do
 $bwa/bwa mem -M -t 6 $ref/Bna_2.0.fna $reads/$name\_R1_m.fastq $reads/$name\_R2_m.fastq | $samtools/samtools view -Sb - > $output_dir/$name.bam
done
