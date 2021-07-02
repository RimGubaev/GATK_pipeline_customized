#!/bin/bash
#$ -l mem_free=5G
#$ -l slt=8
#$ -cwd
##########################################################

export PATH=/biosoftware/conda/bin:$PATH #path to conda

output_dir=$SGE_O_HOME/path_to/reads/aligned #set the output directory

cd $SGE_O_HOME/path_to/reads/aligned

sample_names=$( ls -1 | grep bam | sed 's/.bam//g' ) #collect the sample names in  variable

for name in $sample_names
do
 java -jar $SGE_O_HOME/tools/picard/picard.jar AddOrReplaceReadGroups \
      I=$output_dir/$name.bam \
      O=$output_dir/$name\_rn.bam \
      RGLB=lib1 \
      RGPL=illumina \
      RGPU=unit1 \
      RGSM=$name

 java -jar $SGE_O_HOME/tools/picard/picard.jar SortSam \
  I=$output_dir/$name\_rn.bam \
  O=$output_dir/$name\_rn_sorted.bam \
  SORT_ORDER=coordinate

 java -jar $SGE_O_HOME/tools/picard/picard.jar BuildBamIndex \
  I=$output_dir/$name\_rn_sorted.bam

 rm $name\_rn.bam
done
