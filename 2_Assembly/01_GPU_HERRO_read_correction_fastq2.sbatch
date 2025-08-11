#!/bin/bash
#SBATCH --job-name=HERRO
#SBATCH --output=logs/%x.%A_%a.out
#SBATCH --error=logs/%x.%A_%a.err
#SBATCH --cpus-per-task=32
#SBATCH --nodes=2
#SBATCH --gres=gpu:4
#SBATCH --mem=1000G
#SBATCH --partition=gpu
#SBATCH --time=7-00:00:00
#SBATCH --qos=long
#SBATCH --mail-type=END,FAIL
#SBATCH --array=0-4
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk

# Load miniconda

module load miniconda
# conda 25.5.1
# Python 3.12.11

# Activate dorado-gpu-0.7.2

source activate dorado-gpu-0.7.2

IN_DIR=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_trimmed/trimmed_fastq_2/trimmed/ 
FILES=("$IN_DIR"/*.fastq)
FASTQ="${FILES[$SLURM_ARRAY_TASK_ID]}"
BASENAME=$(basename "$FASTQ" _trimmed.fastq)

# Variables declaration

MODEL_DNA=/home/data/fus_sysbio_ek2020/Tools/dorado-0.7.2-linux-x64/herro-v1
OUT_DIR=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_trimmed/trimmed_fastq_2/trimmed/size_filtered/HERRO_correct
mkdir -p "$OUT_DIR" 

# Run Dorado

dorado correct \
-x "cuda:all" \
--infer-threads 32 \
-m "$MODEL_DNA" "$FASTQ" > "$OUT_DIR/${BASENAME}_corrected.fasta"


