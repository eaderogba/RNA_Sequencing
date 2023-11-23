# Download Saccharomyces Cerevisiae genome
# copyright (c) 2023 - Adebowale Aderogba

# Define the base URI (Uniform Resource Identifier) for the Ensembl FTP site
uri <- "ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/dna/"

# Define the base filename for the Saccharomyces cerevisiae chromosomes
base <- "Saccharomyces_cerevisiae.R64-1-1.dna.chromosome."

# Define the chromosomes to download, including converting numbers to Roman numerals
chrs <- c(as.character(as.roman(seq(1:16))), "Mito")

# Download each chromosome
for(chr in chrs){
  # Construct the filename for the current chromosome
  fname <- paste0(base, chr, ".fa.gz")

  # Construct the wget command to download the chromosome file
  cmd <- paste0("wget ", uri, fname)
  
  # Execute the wget command using the system function in R
  system(cmd)
}

# Create an empty the file
cat("", file = "Saccharomyces_cerevisiae.R64-1-1.dna.primary_assembly.fa")

# Loop to extract and merge chromosome files into a single fast file
for(chr in chrs){
  # Construct the filename for the current chromosome
  fname <- paste0(base, chr, ".fa.gz")

  # Construct the zcat command to extract and merge the chromosome file into a single file
  cmd <- paste0("zcat ", fname, " >> Saccharomyces_cerevisiae.R64-1-1.dna.primary_assembly.fa")
  
  # Execute the zcat command using the system function in R
  system(cmd)
}

# Compress the fasta file using bgzip (keep original)
cmd <- paste0("bgzip -k Saccharomyces_cerevisiae.R64-1-1.dna.primary_assembly.fa")
#cat(cmd, "\n")
system(cmd)

# Delete the chromosomes
for(chr in chrs){
  # Construct the filename for the current chromosome
  fname <- paste0(base, chr, ".fa.gz")
  
  # Construct the rm command to delete the chromosome file
  cmd <- paste0("rm ", fname)
  #cat(cmd, "\n")
  
  # Execute the rm command using the system function in R
  system(cmd)
}
