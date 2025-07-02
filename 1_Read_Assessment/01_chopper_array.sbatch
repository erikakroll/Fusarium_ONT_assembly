#!/bin/bash
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --job-name=chopper_array
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G                   
#SBATCH --time=2-00:00:00
#SBATCH --output=logs/chopper_%A_%a.out
#SBATCH --error=logs/chopper_%A_%a.err
#SBATCH --qos=medium
#SBATCH --array=0-8                

ml Miniconda3/23.9.0-0
source activate /home/data/fus_sysbio_ek2020/conda_envs/conda_envs/Nanoplot

# Define the base directory
BASE_DIR="/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_trimmed/trimmed_fastq"
cd "${BASE_DIR}"

# Create an array of FASTQ files
FASTQ_FILES=(*.fastq)
FILE="${FASTQ_FILES[$SLURM_ARRAY_TASK_ID]}"

# Make sure output directory exists
mkdir -p trimmed

# Create output filename
OUTFILE="trimmed/${FILE%.fastq}_trimmed.fastq"

echo "Running chopper on: $FILE"
echo "Output will be saved to: $OUTFILE"

# Use input redirection via cat, output redirected to OUTFILE
cat "$FILE" | chopper --threads 16 -q 10 -l 500 --headcrop 10 --tailcrop 10 > "$OUTFILE"

