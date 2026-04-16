#!/bin/bash
# FASE 3: Allineamento e Processamento
# Eseguito da ~/Genomics_Project/02_Alignment sul server

DATA_DIR="/home/BCG2025_genomics_exam"

for case in 610 683 657 586 681; do
    for role in mother father child; do
        # 1. Bowtie2: allineamento al genoma di riferimento (chr16)
        # 2. Samtools view: conversione SAM -> BAM
        # 3. Samtools sort: ordinamento per coordinate
        bowtie2 -p 4 -U ${DATA_DIR}/case${case}_${role}.fq.gz \
                -x ${DATA_DIR}/uni \
                --rg-id "${role}" --rg "SM:${role}" | \
        samtools view -Sb - | \
        samtools sort -o case${case}_${role}.bam
        
        # 4. Samtools index: creazione indice .bai
        samtools index case${case}_${role}.bam
    done
done