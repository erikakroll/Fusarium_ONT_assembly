#!/bin/bash
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --job-name=NanoComp_array
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G                   
#SBATCH --time=2-00:00:00
#SBATCH --output=logs/NanoComp_%A_%a.out
#SBATCH --error=logs/NanoComp_%A_%a.err
#SBATCH --qos=medium
#SBATCH --array=0-8 


ml Miniconda3/23.9.0-0
source activate /home/data/fus_sysbio_ek2020/conda_envs/conda_envs/Nanoplot

# Set base directory and move into it
BASE_DIR="/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_trimmed/trimmed_fastq"
cd "${BASE_DIR}"

# Get list of original FASTQ files
FASTQ_FILES=(*.fastq)
FILE="${FASTQ_FILES[$SLURM_ARRAY_TASK_ID]}"
BASENAME="${FILE%.fastq}"

# Define paths to original and trimmed files
ORIGINAL_FILE="${BASE_DIR}/${FILE}"
TRIMMED_FILE="${BASE_DIR}/trimmed/${BASENAME}_trimmed.fastq"

# Define output directory
OUTDIR="${BASE_DIR}/nanocomp_output/${BASENAME}"
mkdir -p "$OUTDIR"

# Run NanoComp
NanoComp --fastq "$ORIGINAL_FILE" "$TRIMMED_FILE" \
         --names original trimmed \
         --outdir "$OUTDIR"

echo "NanoComp run complete for: $BASENAME"
