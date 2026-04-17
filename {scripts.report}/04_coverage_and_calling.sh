#!/bin/bash
# FASE 4: Controllo Copertura (Qualimap) e Variant Calling (Freebayes)
# Eseguito sul server il $(date)

DATA_DIR="/home/BCG2025_genomics_exam"
QC_DIR="$HOME/Genomics_Project/01_QC"
ALN_DIR="$HOME/Genomics_Project/02_Alignment"
VCF_DIR="$HOME/Genomics_Project/03_VariantCalling"

# 1. Qualimap BAMQC
mkdir -p ${QC_DIR}/qualimap
cd ${ALN_DIR}
for case in 610 683 657 586 681; do
    for role in mother father child; do
        qualimap bamqc -bam case${case}_${role}.bam \
                       -gff ${DATA_DIR}/exons16Padded_sorted.bed \
                       -outdir ${QC_DIR}/qualimap/case${case}_${role} \
                       --java-mem-size=2G
    done
done

# 2. Aggiornamento MultiQC
cd ${QC_DIR}
multiqc . -f

# 3. Freebayes Joint Variant Calling
cd ${VCF_DIR}
for case in 610 683 657 586 681; do
    freebayes -f ${DATA_DIR}/universe.fasta \
              -t ${DATA_DIR}/exons16Padded_sorted.bed \
              ${ALN_DIR}/case${case}_mother.bam \
              ${ALN_DIR}/case${case}_father.bam \
              ${ALN_DIR}/case${case}_child.bam \
              > case${case}_trio.vcf
done