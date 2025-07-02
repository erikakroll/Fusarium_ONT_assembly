#!/bin/bash
#################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#SBATCH --qos=medium
#job name
#SBATCH --job-name=RepeatMasker
#SBATCH --cpus-per-task=30
#job stdout file
#SBATCH --output=logs/RepeatMasker.out.%J
#job stderr file
#SBATCH --error=logs/RepeatMasker.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=0-05:00
#SBATCH --mem=15G
#################################################################

### module load statements
ml GCCcore/13.2.0
ml RepeatModeler/2.0.4-foss-2022a
ml RepeatMasker/4.1.5-foss-2022a

cd /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_annotation

#0. Variable declaration
INPUT=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/CML3064_HERRO_Chr4_telo.fixed.T2T.fasta
DB=genome
#1. Create a Database for RepeatModeler

#BuildDatabase -name $DB $INPUT

#2. Run RepeatModeler

#RepeatModeler -database $DB -threads 30 -LTRStruct

ln -s RM_*/consensi.fa.classified ./

#3. Repeat masking with RepeatMasker using species-specific repeats that were found by RepeatModeler
RepeatMasker -pa 32 -gff -lib consensi.fa.classified $INPUT
