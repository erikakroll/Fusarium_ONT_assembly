#!/bin/bash
#################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#job name
#SBATCH --job-name=OMArk
#job stdout file
#SBATCH --output=logs/OMArk.out.%J
#job stderr file
#SBATCH --error=logs/OMArk.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=1-00:00
#maximum memory of 20Gb
#SBATCH --mem-per-cpu=20000
#SBATCH --ntasks=1
#SBATCH --array=0-7                
#############################################################
module load Miniconda3
source activate /home/data/fus_sysbio_ek2020/conda_envs/OMArk
#############################################################

cd /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_annotation/CML3064/OMArk/

# Create an array of proteome files
FASTA_FILES=(proteome/*.fa)

# Select file for this array task
FILE="${FASTA_FILES[$SLURM_ARRAY_TASK_ID]}"

# Extract base filename without extension and directory
BASE=$(basename "$FILE" .fa)

# Corresponding splice file path
SPLICE_FILE="splice/${BASE}.splice"

mkdir -p results

omamer search \
--db LUCA.h5 \
--query $FILE \
--out "results/${BASE}.omamer"

mkdir -p results/omark_output

omark -f "results/${BASE}.omamer" -o "results/omark_output/${BASE}" --isoform_file $SPLICE_FILE -d LUCA.h5
