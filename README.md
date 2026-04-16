# Molecular Diagnosis of Rare Genetic Disorders

## 1. ABSTRACT
(Da compilare alla fine del progetto con un riassunto dei risultati).

## 2. INTRODUCTION
The objective of this project is the molecular diagnosis of rare Mendelian genetic disorders in 5 distinct family trios using whole-exome sequencing (WES) data. The analysis focuses on chromosome 16 (assembly hg19).

**Patient Cohort & Inheritance Models:**
* **Case 610:** Autosomal Recessive (AR)
* **Case 683:** Autosomal Dominant (AD)
* **Case 657:** Autosomal Dominant (AD)
* **Case 586:** Autosomal Dominant (AD)
* **Case 681:** Autosomal Dominant (AD)

**Genomics Context:**
* **Reference Genome:** hg19 (`universe.fasta`)
* **Target Region BED:** `exons16Padded_sorted.bed`
* **Data Location:** `/home/BCG2025_genomics_exam`

## 3. MATERIALS AND METHODS
**Step 1: Quality Control**
Raw sequencing reads (FASTQ format) for the 5 family trios were assessed for quality using `FastQC`. The individual reports were subsequently aggregated into a single comprehensive report using `MultiQC` to evaluate global sequencing metrics such as Phred quality scores, GC content, and sequence duplication levels.

**Step 2: Read Alignment and Processing**
High-quality reads were aligned to the human reference genome assembly hg19 (specifically chromosome 16) using `Bowtie2`. Read groups were explicitly assigned to distinguish maternal, paternal, and proband sequences. The resulting SAM files were directly piped into `Samtools` to convert them into compressed BAM format, sorted by genomic coordinates, and indexed for efficient downstream variant calling and visualization.

## 4. RESULTS
*Qui inseriremo le tabelle dei casi, i grafici MultiQC e la visualizzazione UCSC/IGV.*

## 5. DISCUSSION
*Commenti sui risultati di VEP, insight biologici e considerazioni tecniche.*

## 6. DATA AVAILABILITY
The scripts and the pipeline used for this analysis are tracked and available in the GitHub repository.

## 7. CONCLUSION
(Da compilare alla fine).

## 8. LITERATURE CITED
(Referenze bibliografiche).