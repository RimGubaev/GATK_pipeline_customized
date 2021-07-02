#!/bin/bash
#$ -l mem_free=24G
#$ -l slt=8
#$ -cwd
##########################################################

export PATH=/biosoftware/conda/bin:$PATH #path to conda
cd $SGE_O_HOME/path_to/reads/demux #goto directory with the demux reads 
reads=$SGE_O_HOME/path_to/reads/demux #set the reads directory
barcodes=$SGE_O_HOME/path_to/reads #set the directory with barcodes
output_dir=$SGE_O_HOME/path_to/reads/trimmed #set the output directory
log_dir=$SGE_O_HOME/path_to/reads/logs

sample_names=$(awk '{print $2}' $barcodes/barcodes.tsv | sort -u | sed -r '/^\s*$/d') #collect the sample names in  variable 

#run trimmomatic over different reads in different lanes

for lane in 1 2 3 4
do
	for readname in $sample_names
	do
	java -jar $SGE_O_HOME/tools/Trimmomatic-0.38/trimmomatic-0.38.jar PE -threads 8 \
				$reads/l$lane\_$readname\_R1.fastq \
				$reads/l$lane\_$readname\_R2.fastq \
				$output_dir/l$lane\_$readname\_R1_t.fastq \
				$output_dir/l$lane\_$readname\_R1_tu.fastq \
				$output_dir/l$lane\_$readname\_R2_t.fastq \
				$output_dir/l$lane\_$readname\_R2_tu.fastq \
				ILLUMINACLIP:adapters.fa:2:30:10 \
				HEADCROP:15 SLIDINGWINDOW:4:18 MINLEN:45
	done
done

