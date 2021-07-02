# GATK_pipeline_customized

This collection of scripts was generated in order to adapt GATK pipeline for reduced representation sequencing approaches like GBS or RAD-seq to perform SNP calling.

The scripts are numbered in the order of application and perform the following functions:

1_GATK_pipeline_run_demultiplexing.sh - uses barcodes table to demultiplex reads into sample-specific fastq.gz bins

2_GATK_pipeline_run_trimmomatic2.sh - standart read filtering with trimmomatic, FastQC visualisation is highly recommended before filter application

3_GATK_generate_indexes.sh - creates indexes for alignment

4_GATK_pipeline_run_alignment.sh - alignment over multiple samples with bwa + samtools using "for" loop

5_GATK_pipeline_add_read_groups_run_sorting.sh - adds read groups to bam files and sorts corresponding bams. this step is OBLIGATORY for siccesefull calling

6_GATK_pipeline_generate_individual_vcfs.sh - performs SNP calling for individual bam files

7_GATK_pipeline_combine_individual_vcfs.sh - combines individual vcfs into one joint vcf. NOTE! the output vcf might be large!

8_GATK_pipeline_genotype_combined_vcf.sh - performs genotyping on combined vcf

9_GATK_pipeline_variant_filtration.sh - Basic variant filtration based on INFO field in vcf file. A useful manual for variant filtration id avilable [here](https://gatk.broadinstitute.org/hc/en-us/articles/360035890471-Hard-filtering-germline-short-variants)

Software used:
axe-demux v.0.3.3-2-ge23af27
trimmomatic v.0.38
samtools v.1.9
bwa v.0.7.17
picard v.2.18.22
GATK v.4.1.0.0


Disclaimer: presented scripts are NOT ready-to-go solution, however may serev a as a n example on how to adapt GATK pipeline for GBS and RAD seq data. For more details and help don't hestitate to contact.

Email: rimgubaev@gmail.com

This customized pipline was used in the following publication:

Gubaev, R.; Gorlova, L.; Boldyrev, S.; Goryunova, S.; Goryunov, D.; Mazin, P.; Chernova, A.; Martynova, E.; Demurin, Y.; Khaitovich, P. Genetic Characterization of Russian Rapeseed Collection and Association Mapping of Novel Loci Affecting Glucosinolate Content. Genes 2020, 11, 926. https://doi.org/10.3390/genes11080926 
