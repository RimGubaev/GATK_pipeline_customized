
#!/bin/bash
#$ -l mem_free=36G
#$ -l slt=8
#$ -cwd
##########################################################

export PATH=/biosoftware/conda/bin:$PATH
cd $SGE_O_HOME/path_to/variants
vcf_path=$SGE_O_HOME/path_to/variants
ref=$SGE_O_HOME/path_to/ref

# a link to filter recommendations
# https://software.broadinstitute.org/gatk/documentation/article.php?id=3225
 
# Run VariantFiltration on combined vcfs
~/tools/gatk-4.1.0.0/gatk --java-options "-Xmx36G" VariantFiltration \
   -R $ref/Bna_2.0.fna \
   -V $vcf_path/rapeseed.cohort.genotype.vcf \
   --output $vcf_path/rapeseed.cohort.genotype.maf0.05.filtered.vcf \
   --filter-expression "MQ < 40.0" --filter-name "MQ40" \
   --filter-expression "QD < 24.0" --filter-name "QD24" \
   --filter-expression "MQRankSum < -2.0" --filter-name "MQRankSum2L" \
   --filter-expression "MQRankSum > 2.0" --filter-name "MQRankSum2R" \
   --filter-expression "FS > 60.0" --filter-name "FS60" \
   --filter-expression "SOR > 3.0" --filter-name "SOR3" \
   --filter-expression "DP < 20.0" --filter-name "DP20" \
   --filter-expression "AF < 0.05" --filter-name "LowAF" \
   --filter-expression "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
   --filter-expression "AF > 0.99" --filter-name "HighAF"


# SelectVariants needed to select SNPs with flag "PASS"
~/tools/gatk-4.1.0.0/gatk SelectVariants \
	 --variant $vcf_path/rapeseed.cohort.genotype.maf0.05.filtered.vcf \
	 -O $vcf_path/rapeseed.cohort.genotype.filtered.maf0.05.nocall0.5.SNP.biallelic.vcf \
         -select-type SNP \
	 --restrict-alleles-to BIALLELIC \
         --max-nocall-fraction 0.5 \
	 --exclude-non-variants \
	 --set-filtered-gt-to-nocall

#SelectVariants that passed the filters
~/tools/gatk-4.1.0.0/gatk SelectVariants \
         --variant $vcf_path/rapeseed.cohort.genotype.filtered.maf0.05.nocall0.5.SNP.biallelic.vcf \
         -O $vcf_path/rapeseed.cohort.genotype.filtered.maf0.05.nocall0.5.SNP.biallelic.selected.vcf \
         --select "vc.isNotFiltered()"


~/tools/gatk-4.1.0.0/gatk --java-options "-Xmx36G" VariantsToTable \
	-R ~/path_to/ref/Bna_2.0.fna \
	-V $vcf_path/rapeseed.cohort.genotype.filtered.maf0.05.nocall0.5.SNP.biallelic.vcf \
	--output $vcf_path/rapeseed.cohort.genotype.filtered.maf0.05.nocall0.5.SNP.biallelic.table \
	-F CHROM -F POS -F ID -F REF -F ALT -F QUAL -F FILTER -F MQ -F QD \
	-F MQRankSum -F FS -F SOR -F DP -F AF -F ReadPosRankSum -F InbreedingCoeff \
	--show-filtered true
	
# command to calculate the number of SNPs
# grep -v "#" rapeseed.cohort.genotype.filtered.SNP.biallelic.selected.vcf | wc -l

# Optionally the table of filtered phenotypes could be obtained (think it should be run on main)
#~/tools/gatk-4.1.0.0/gatk --java-options "-Xmx36G" VariantsToTable -R ~/rapeseed/ref/Bna_2.0.fna 
       # -V ~/rapeseed/variants/rapeseed.cohort.genotype.vcf
       # --output ./rapeseed.cohort.genotype.table
