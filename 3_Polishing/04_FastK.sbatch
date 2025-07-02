#!/bin/bash
#################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#SBATCH --qos=medium
#job name
#SBATCH --job-name=MerquryFK
#job stdout file
#SBATCH --output=logs/MerquryFK.out.%J
#job stderr file
#SBATCH --error=logs/MerquryFK.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=1-00:00
#SBATCH --mem-per-cpu=10000
###########################################################
############## module load statements #########################
ml Miniconda3

source activate merquryfk

## Run FastK
FastK -k21 -t16 -NTable -v -M200 -T16 /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_trimmed/trimmed_fastq_2/herro_corrected/over10_CML_3064_bc01.corrected.fasta

## Run MerquryFK 
MerquryFK -w6.0 -h4.5 -v -lfs -pdf -z -T16 Table.ktab /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/CML_3064_T2T_polished.fasta CML_3064_T2T_polished
