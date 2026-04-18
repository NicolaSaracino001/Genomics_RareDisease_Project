#!/bin/bash
# FASE 6: Annotazione funzionale delle varianti
# METODO: Interfaccia Web Ensembl VEP (Genoma di Riferimento: GRCh37/hg19)
# LINK: https://grch37.ensembl.org/Homo_sapiens/Tools/VEP
#
# Parametri utilizzati per l'analisi:
# - Genoma: GRCh37
# - Regione d'interesse: CROMOSOMA 16
# - Transcript database: RefSeq transcripts
# - Frequency data: 1000 Genomes (global MAF) & gnomAD (exomes)
# - Phenotypes & literature: Variants already associated to disease & DisGeNet
# - Filtering options: Restrict results -> IMPACT is HIGH
#
# I file VCF del cromosoma 16 sono stati scaricati in locale per l'analisi web.