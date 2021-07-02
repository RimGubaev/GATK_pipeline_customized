
#!/bin/bash
#$ -l mem_free=36G
#$ -l slt=8
#$ -cwd
##########################################################

export PATH=/biosoftware/conda/bin:$PATH
cd $SGE_O_HOME/path_to/variants/samples
vcf_path=$SGE_O_HOME/path_to/variants/samples
ref=$SGE_O_HOME/path_to/ref

# the first option is to run GenotypeGVCFs on database (gendb) created by -- 
$SGE_O_HOME/tools/gatk-4.1.0.0/gatk --java-options "-Xmx36G" GenotypeGVCFs \
   -R $ref/Bna_2.0.fna \
   -V $vcf_path/rapeseed.samples.vcf \
   -O $vcf_path/rapeseed.samples.genotype.vcf \
   --max-alternate-alleles 2

