#!/bin/bash
#################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#SBATCH --qos=medium
#job name
#SBATCH --job-name=bwa
#job stdout file
#SBATCH --output=logs/bwa.out.%J
#job stderr file
#SBATCH --error=logs/bwa.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=1-00:00
#SBATCH --mem=20G
###########################################################
############## module load statements #########################


ml BWA/0.7.17-intel-2018a
ml SAMtools/1.18-GCC-12.3.0

ASSEMBLY=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/CML_3064_T2T.fasta
FASTQ_1=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Fgraminearum_strains_for_Pangenome_analysis/1st_batch/CML3064/1321_LIB14417_LDI12017_GATCAG_L003_R1.fastq.gz
FASTQ_2=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Fgraminearum_strains_for_Pangenome_analysis/1st_batch/CML3064/1321_LIB14417_LDI12017_GATCAG_L003_R2.fastq.gz

bwa index ${ASSEMBLY}

bwa mem -t 8  ${ASSEMBLY} ${FASTQ_1} ${FASTQ_2} > CML_3064_T2T.mapped.sam

samtools view -bS CML_3064_T2T.mapped.sam | samtools sort -o CML_3064.T2T.mapped.sorted.bam                                                                                                         
samtools index CML_3064.T2T.mapped.sorted.bam


