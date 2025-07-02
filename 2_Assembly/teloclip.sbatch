#!/bin/bash
#################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#SBATCH --qos=medium
#job name
#SBATCH --job-name=teloextension
#job stdout file
#SBATCH --output=logs/teloextension.out.%J
#job stderr file
#SBATCH --error=logs/teloextension.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=0-10:00
#SBATCH --mem=10G

#############################################################
#module load statements

ml SAMtools/1.18-GCC-12.3.0
ml SeqKit/2.2.0
ml Miniconda3
ml minimap2/2.26-GCCcore-12.3.0

cd /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/

#### Chr4 extension 

#Hifi_ASSEMBLY=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/CML_3064_T2T.fasta


#samtools faidx ${Hifi_ASSEMBLY} ptg000005l:1-7919119 > ptg000005l_trimmed.fasta

#cat CML_3064_hifi_chr1,2,3,mito.fasta ptg000005l_trimmed.fasta > CML3064_T2T_trimmed.fasta

#source activate /home/data/fus_sysbio_ek2020/conda_envs/teloclip

#samtools view -h T2T_CML3064_aligned_HERRO.sorted.bam | teloclip --ref CML3064_T2T_trimmed.fasta.fai | samtools sort > out.teloclip.CML3064_T2T_trimmed.bam

#samtools view out.teloclip.CML3064_T2T_trimmed.bam "ptg000005l:7876950-8118443" > teloclip.ptg000005l.5_prime_telo.bam

samtools consensus -f fasta out.teloclip.CML3064_T2T_trimmed.bam -o consensus.teloclip.ptg000005l.fa



minimap2 -c CML3064_T2T_trimmed.fasta consensus.teloclip.ptg000005l.fa > CML3064_trimmed_vs_teloclip.paf



