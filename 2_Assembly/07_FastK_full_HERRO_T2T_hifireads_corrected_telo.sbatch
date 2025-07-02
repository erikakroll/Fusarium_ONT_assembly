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
#SBATCH --time=0-03:00
#SBATCH --mem=30G
###########################################################
############## module load statements #########################
ml Miniconda3
ml SeqKit

source activate merquryfk

cd /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assessment/HERRO/HERRO_Hifi_ktab

#seqkit fq2fa /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/over10.write_reads_Hifi.CML_3064_bc01.asm.ec.fq -o over10.write_reads_Hifi.CML_3064_bc01.asm.ec.fasta

## Run FastK
#FastK -k21 -t16 -NTable -v -M200 -T16 /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_trimmed/trimmed_fastq_2/herro_corrected/over10_CML_3064_bc01.corrected.fasta over10.write_reads_Hifi.CML_3064_bc01.asm.ec.fasta

## Run MerquryFK 
MerquryFK -w6.0 -h4.5 -v -lfs -pdf -z -T16 Table.ktab /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/CML_3064_corrected_telo.fa CML_3064_corrected_telo
