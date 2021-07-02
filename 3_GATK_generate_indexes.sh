#!/bin/bash
#$ -l mem_free=24G
#$ -l slt=8
#$ -cwd
##########################################################

export PATH=/biosoftware/conda/bin:$PATH #path to conda
cd $SGE_O_HOME/path_to/ref #path to reference
ref=$SGE_O_HOME/path_to/ref/genome.fa #set the reference directory 
output_dir=$SGE_O_HOME/path_to/ref #set the output directory

$SGE_O_HOME/tools/bwa-0.7.17/bwa index $ref #index the genome using bwa

$SGE_O_HOME/tools/samtools-1.9/samtools faidx $ref #index genome using samtools should be run separately on main cluster

java -jar $SGE_O_HOME/tools/picard/picard.jar CreateSequenceDictionary R=genome.fa O=genome.dict #create the dictionary using picard
