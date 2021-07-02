#!/bin/bash
#$ -l mem_free=24G
#$ -l slt=8
#$ -cwd
##########################################################

export PATH=/biosoftware/conda/bin:$PATH #path to conda
cd $SGE_O_HOME/path_to/reads/demux # wd is demux directory
barcodes=$SGE_O_HOME/path_to/reads/barcodes.tsv
reads=$SGE_O_HOME/../path_to/reads/raw  #set the raw reads directory 

#demultiplex reads from dufferent lanes

$SGE_O_HOME/tools/axe/bin/axe-demux -mzc2pt -f $reads/Undetermined_reads_from_lane3_R1.fastq.gz -F l3 \
-r $reads/Undetermined_reads_from_lane3_R2.fastq.gz -R l3 -b $barcodes -t table_lane3.txt  

$SGE_O_HOME/tools/axe/bin/axe-demux -mzc2pt -f $reads/Undetermined_reads_from_lane2_R1.fastq.gz -F l2 \
-r $reads/Undetermined_reads_from_lane2_R2.fastq.gz -R l2 -b $barcodes -t table_lane2.txt

