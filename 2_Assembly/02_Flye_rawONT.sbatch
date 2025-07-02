#!/bin/bash
#################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#SBATCH --qos=medium
#job name
#SBATCH --job-name=flye
#job stdout file
#SBATCH --output=logs/flye.out.%J
#job stderr file
#SBATCH --error=logs/flye.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=1-00:00
#SBATCH --mem-per-cpu=5000
#SBATCH --ntasks=30
#SBATCH --nodes=1
#############################################################
#module load statements
module load Python 
#############################################################
FASTQ=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_trimmed/trimmed_fastq_2/trimmed/CML_3064_bc01_trimmed.fastq
PREFIXOUT='Flye.CML_3064_bc01.asm'

python /home/data/fus_sysbio_ek2020/Tools/Flye/bin/flye --nano-raw "${FASTQ}" --out-dir Flye --threads 30
######################################################################################
