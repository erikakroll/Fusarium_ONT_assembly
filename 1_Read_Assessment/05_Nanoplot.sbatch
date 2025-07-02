#!/bin/bash
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL 
#SBATCH --job-name=NanoPlot      # Job name
#SBATCH --partition=standard            # Specify the partition/queue
#SBATCH --nodes=1                       # Number of nodes
#SBATCH --ntasks=8                      # Total number of tasks
#SBATCH --cpus-per-task=1               # Number of CPU cores per task
#SBATCH --mem=9G                        # Total memory per node
#SBATCH --time=2-00:00:00               # Time limit (2 d)                  # K-mer sizes to test
#SBATCH --output=logs/Nanoplot_%A_%a.out   # Standard output
#SBATCH --error=logs/Nanoplot_%A_%a.err    # Standard error
#SBATCH --qos=medium

ml Miniconda3

source activate /home/data/fus_sysbio_ek2020/conda_envs/conda_envs/Nanoplot

# Define the base directory (change to the absolute path of your working directory)
BASE_DIR="/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_SH"


# Loop over each strain directory
for STRAIN_DIR in "${BASE_DIR}"/*/; do

    FASTQ=$(ls "${STRAIN_DIR}"/*.fastq.gz)

    NanoPlot -t 8 --fastq ${FASTQ} --loglength -o "${STRAIN_DIR}/Nanopore_nanoplot" --plots dot --verbose

done