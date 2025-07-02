#!/bin/bash
#################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#SBATCH --qos=medium
#job name
#SBATCH --job-name=minimap2
#job stdout file
#SBATCH --output=logs/minimap2.out.%J
#job stderr file
#SBATCH --error=logs/minimap2.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=0-10:00
#SBATCH --mem=10G

#############################################################
#module load statements

ml minimap2/2.26-GCCcore-12.3.0
ml SAMtools/1.18-GCC-12.3.0

ASSEMBLY1=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/HERRO_Hifi/HERRO_assembly.fasta
ASSEMBLY2=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/CML_3064_hifi_raw.fasta

minimap2 -x asm5 -t 8 $ASSEMBLY1 $ASSEMBLY2 > CML3064_Herro_vs_Hifi.paf

