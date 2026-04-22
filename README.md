# Clinical Bioinformatics: Trio Analysis for Rare Disease Diagnosis

## 1. ABSTRACT
This repository documents the complete bioinformatics pipeline and clinical analysis conducted on 5 family trios (father, mother, child). 
The primary objective of this project is to identify and isolate pathogenic genetic variants responsible for rare Mendelian disorders using genomic sequencing data.

The analysis evaluated two distinct Mendelian inheritance models: **Autosomal Recessive (AR)** and **Autosomal Dominant (AD)**, with a specific focus on identifying *de novo* mutations for the latter (variants arising spontaneously in the child that are completely absent in both parents).

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
Variants were rigorously filtered based on the specific Mendelian inheritance patterns of each family using `bcftools`. A stringent baseline quality filter (`QUAL > 20`) was applied to remove low-confidence calls and sequencing artifacts. 
* **Autosomal Recessive (AR):** For Case 610, variants were retained if the proband was homozygous for the alternate allele (`1/1`) and both parents were heterozygous carriers (`0/1`). 
  * *Command applied:* `bcftools view -i 'QUAL>20 && FORMAT/GT[0]="1/1" && FORMAT/GT[1]="0/1" && FORMAT/GT[2]="0/1"'`
* **Autosomal Dominant (AD) / *De novo*:** For Cases 586, 657, 681, and 683, the analysis targeted *de novo* mutations. Variants were retained if the proband was heterozygous (`0/1`) and both parents were homozygous for the reference allele (`0/0`).
  * *Command applied:* `bcftools view -i 'QUAL>20 && FORMAT/GT[0]="0/1" && FORMAT/GT[1]="0/0" && FORMAT/GT[2]="0/0"'`

**Step 6: Variant Annotation (Ensembl VEP Web Interface)**
Variant functional annotation was performed using the **Ensembl VEP** web interface, specifically utilizing the dedicated **GRCh37 (hg19)** assembly portal to ensure perfect genomic coordinate matching with the generated VCF files. The analysis was strictly focused on **Chromosome 16**.

To identify the causal mutation among the candidates, a multi-stage filtering strategy was applied based on the following criteria:
1. **Impact and Consequence Filter:** Priority was given to variants with **IMPACT: HIGH** (e.g., stop_gained, frameshift_variant). Variants with **IMERATE (Moderate)** impact (e.g., missense_variant) were only considered if no high-impact candidates were identified within the inheritance model.
2. **Population Frequency Filter (gnomAD):** Only rare variants were retained. Candidates were required to have a near-zero allele frequency in the **gnomAD** database or be completely absent (novel variants marked with `-`). High-frequency variants or known population polymorphisms (e.g., *IL34* variants with AF > 10%) were discarded as non-pathogenic.
3. **Clinical Significance (CLIN_SIG):** Variants were filtered using the `CLIN_SIG` column to identify those already reported as **Pathogenic** or **Likely Pathogenic** in clinical databases like ClinVar.
4. **Phenotype Correlation:** The surviving variants were cross-referenced with the **Phenotypes** column. A variant was only confirmed as the diagnostic cause if the mutated gene was explicitly associated with a known clinical condition (e.g., *CREBBP* with Rubinstein-Taybi syndrome). Conversely, *de novo* mutations in genes with no clinical phenotype association (e.g., *TMC5*, *PRSS41*) were classified as benign/innocent events.

Results were exported in tabular format for subsequent bioinformatics analysis and clinical interpretation.

## 4. RESULTS
The clinical bioinformatics pipeline successfully processed and filtered the genomic data for the 5 family trios. The final diagnostic outcomes are summarized in the table below, followed by detailed clinical reports for each individual case.

### 4.1 Summary of Findings

| Case ID | Inheritance Model | Mutated Gene | Variant Location | Consequence | Clinical Phenotype | Final Diagnosis |
|---------|-------------------|--------------|------------------|-------------|--------------------|-----------------|
| **610** | Autosomal Recessive | - | - | - | - | **Healthy** (No pathogenic AR variants) |
| **586** | Autosomal Dominant | *TMC5* | 16:19451558-19451563 | Frameshift | None (-) | **Healthy** (Benign *de novo* variant) |
| **657** | Autosomal Dominant | *CYLD* | 16:50788249-50788254 | Frameshift | Familial Cylindromatosis | **Familial Cylindromatosis** |
| **681** | Autosomal Dominant | *CREBBP* | 16:3820696 | Stop Gained | Rubinstein-Taybi Syndrome | **Rubinstein-Taybi Syndrome** |
| **683** | Autosomal Dominant | *PRSS41* | - | - | None (-) | **Healthy** (Benign *de novo* variant) |

### 4.2 Detailed Clinical Reports

**Case 610**
Case 610 was determined not to be associated with any genetic disease. Following the Autosomal Recessive (AR) filtering model (proband 1/1, parents 0/1), no variants passed the stringent clinical criteria regarding population frequency, functional impact, and known pathological phenotypes. The patient is considered clinically healthy.

**Case 586**
Case 586 was determined not to be associated with any disease. The genetic analysis of the child revealed a *de novo* frameshift variant in the *TMC5* gene (16:19451558-19451563, G deletion). While this variant displayed potentially pathogenic characteristics—such as a high impact on the protein structure and a completely novel frequency in the population databases—the absence of any associated phenotype in the clinical databases excludes it from being classified as pathogenic. The patient is clinically healthy.

**Case 657**
Case 657 was determined to be associated with Familial Cylindromatosis. The genetic analysis of the child revealed a pathogenic *de novo* frameshift variant in the *CYLD* gene (16:50788249-50788254, GATG deletion). This variant presents highly pathogenic characteristics: it has a severe impact on the protein structure and is completely novel, as indicated by its absence in population databases (gnomAD). Furthermore, clinical databases explicitly associate the disruption of the *CYLD* gene with Familial Cylindromatosis. 

**Case 681**
Case 681 was determined to be associated with Rubinstein-Taybi syndrome. The genetic analysis of the child identified a *de novo* nonsense variant (*stop_gained*) in the *CREBBP* gene (16:3820696, G>A substitution). This variant is characterized by a high impact on the protein, leading to a premature stop codon. Furthermore, it is absent from population databases (gnomAD) and is explicitly annotated as pathogenic in clinical databases (ClinVar). The severe disruption of the *CREBBP* gene is a well-established cause of Rubinstein-Taybi syndrome.

**Case 683**
Case 683 was determined not to be associated with any genetic disease. The analysis of the trio identified a *de novo* variant in the *PRSS41* gene. However, a review of clinical databases revealed an absence of any known phenotype or disease association for this gene. Additional variants detected in genes like *IL34* and *TMC5* were discarded as systematic sequencing artifacts and high-frequency benign polymorphisms. The patient is clinically healthy.

## 5. DISCUSSION
*Commenti sui risultati di VEP, insight biologici e considerazioni tecniche.*

## 6. DATA AVAILABILITY
The scripts and the pipeline used for this analysis are tracked and available in the GitHub repository.

## 7. CONCLUSION
(Da compilare alla fine).

## 8. LITERATURE CITED
(Referenze bibliografiche).