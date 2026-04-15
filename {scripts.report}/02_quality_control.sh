#!/bin/bash
# FASE 2: Controllo di qualità (FastQC & MultiQC)
# Eseguito da /home/BCG2025_saracinoN/Genomics_Project/01_QC

DATA_DIR="/home/BCG2025_genomics_exam"

# Analisi FastQC sui file raw dei 5 casi
for case in 610 683 657 586 681; do
    fastqc -t 2 ${DATA_DIR}/case${case}_*.fq.gz -o .
done

# Aggregazione dei report FastQC
multiqc .