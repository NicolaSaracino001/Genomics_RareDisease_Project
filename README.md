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

**Step 3: Coverage Analysis**
Post-alignment quality control was performed using `Qualimap` (bamqc mode) to compute target region coverage, relying on the provided BED file. The alignment metrics were subsequently integrated into the global `MultiQC` report to verify that minimum coverage thresholds (e.g., ≥5X, ≥10X) were met across all samples.

**Step 4: Variant Calling and Target Region Restriction**
Single Nucleotide Polymorphisms (SNPs) and small Insertions/Deletions (InDels) were identified using `Freebayes`. To optimize computational efficiency and restrict the analysis strictly to the regions of interest (WES approach), variant calling and coverage analyses were limited to the exonic regions of chromosome 16. This was achieved by providing a target BED file (`exons16Padded_sorted.bed`), previously processed and formatted using `bedtools`. A joint calling approach was applied for each family trio to simultaneously evaluate the proband and parental alignments, improving variant detection accuracy. The output was generated in Variant Call Format (VCF).

**Step 5: Variant Filtering**
Variants were rigorously filtered based on the specific Mendelian inheritance patterns of each family using `bcftools`. For the autosomal recessive case, variants were retained if the proband was homozygous for the alternate allele and both parents were heterozygous carriers. For autosomal dominant cases, variants were retained if the proband was heterozygous and at most one parent was affected (accommodating both inherited and *de novo* events). A stringent baseline quality filter (QUAL > 20) was subsequently applied to remove low-confidence calls and sequencing artifacts.

**Step 6: Variant Annotation (Ensembl VEP Web Interface)**
Variant functional annotation was performed using the **Ensembl VEP** web interface, specifically utilizing the dedicated **GRCh37 (hg19)** assembly portal to ensure perfect genomic coordinate matching with the generated VCF files. The analysis was strictly focused on **Chromosome 16**.

To maximize the clinical relevance of the research, the following parameters and filters were applied:
* **Transcript Database:** **RefSeq** transcripts were used to ensure high-quality, manually curated annotations.
* **Population Frequency Filters:** Common variants were excluded using the **1000 Genomes** (global MAF) and **gnomAD** (exomes) databases.
* **Pathogenicity and Phenotype Data:** Clinical association plugins (e.g., ClinVar, OMIM) were integrated. 
  * *Technical note: The DisGeNet plugin was omitted as it is currently deprecated/unsupported on the Ensembl web platform for the GRCh37 build.*
* **Functional Impact Filter:** Strict filtering for variants with **IMPACT: HIGH** (e.g., frameshifts, stop-gains, canonical splice sites) was applied to isolate the mutations with the highest probability of being disease-causing.

Results were exported in tabular format for subsequent bioinformatics analysis and clinical interpretation.

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