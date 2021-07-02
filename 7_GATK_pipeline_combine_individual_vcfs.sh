
#!/bin/bash
#$ -l mem_free=36G
#$ -l slt=8
#$ -cwd
##########################################################

#export PATH=$PATH:/usr/lib/
#export LD_LIBRARY_PATH=$SGE_O_HOME/../../lib64/
#export LIBRARY_PATH=$SGE_O_HOME/../../lib64/

export PATH=/biosoftware/conda/bin:$PATH
cd $SGE_O_HOME/path_to/variants/samples
vcf_path=$SGE_O_HOME/path_to/variants/samples
ref=$SGE_O_HOME/path_to/ref

# make the list of samples
samples=$(find . | sed 's/.\///' | grep -E 'g.vcf$' | sed 's/^/--variant /')

#make joint vcf file
$SGE_O_HOME/tools/gatk-4.1.0.0/gatk --java-options "-Xmx36G" CombineGVCFs \
   $(echo $samples) \
   -O $vcf_path/rapeseed.samples.vcf \
   -R $ref/genome.fa
