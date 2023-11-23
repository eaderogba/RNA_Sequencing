# Get the reference transcriptome and GTF for STAR
wget https://ftp.ensembl.org/pub/release-110/gtf/saccharomyces_cerevisiae/Saccharomyces_cerevisiae.R64-1-1.110.gtf.gz

wget https://ftp.ensembl.org/pub/release-110/variation/vcf/saccharomyces_cerevisiae/saccharomyces_cerevisiae.vcf.gz

gunzip -k Saccharomyces_cerevisiae.R64-1-1.110.gtf.gz

# Index the genome using samtools
samtools faidx Saccharomyces_cerevisiae.R64-1-1.dna.primary_assembly.fa.gz

# Generate genome/transcriptome index using STAR
STAR --runThreadN 2 --runMode genomeGenerate \
    --genomeDir /home/eaderogba279/Analysing_and_Interpreting_Genomic_Datasets/RNA_Sequencing/genome/STAR \
    --genomeSAindexNbases 10 \
    --sjdbGTFfile /home/eaderogba279/Analysing_and_Interpreting_Genomic_Datasets/RNA_Sequencing/genome/Saccharomyces_cerevisiae.R64-1-1.110.gtf \
    --genomeFastaFiles /home/eaderogba279/Analysing_and_Interpreting_Genomic_Datasets/RNA_Sequencing/genome/Saccharomyces_cerevisiae.R64-1-1.dna.primary_assembly.fa

# Get the reference SNPs and index using tabix
tabix saccharomyces_cerevisiae.vcf.gz

# Index the genome using picard
java -Xmx4g -jar /home/eaderogba279/software_trimmomatic/picard/build/libs/picard.jar CreateSequenceDictionary \
    -R Saccharomyces_cerevisiae.R64-1-1.dna.primary_assembly.fa.gz
