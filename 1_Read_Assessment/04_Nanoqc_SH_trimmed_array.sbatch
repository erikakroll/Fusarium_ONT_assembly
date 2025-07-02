#!/bin/bash
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --job-name=NanoQC_array
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G                   
#SBATCH --time=2-00:00:00
#SBATCH --output=logs/NanoQC_%A_%a.out
#SBATCH --error=logs/NanoQC_%A_%a.err
#SBATCH --qos=medium
#SBATCH --array=0-6                

ml Miniconda3/23.9.0-0
source activate /home/data/fus_sysbio_ek2020/conda_envs/conda_envs/Nanoplot

# Define the base directory
BASE_DIR="/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_trimmed/trimmed_fastq_2"
cd ${BASE_DIR}

# Create an array of FASTQ files
FASTQ_FILES=(*.fastq)
FILE="${FASTQ_FILES[$SLURM_ARRAY_TASK_ID]}"

echo "Running NanoQC on: $FILE"

# Output directory (you can create it beforehand)
OUTDIR="Nanopore_nanoqc/${FILE%.fastq}"
mkdir -p "$OUTDIR"

# Run NanoQC
nanoQC -o "$OUTDIR" "$FILE"
