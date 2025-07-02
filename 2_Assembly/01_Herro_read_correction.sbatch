#!/bin/bash
#SBATCH --job-name=herro
#SBATCH --nodes=1
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --cpus-per-task=32
#SBATCH --mem=1000G
#SBATCH --partition=largemem
#SBATCH --time=1-00:00:00
#SBATCH --qos=largemem
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk

# Set paths
model_dna=/home/data/fus_sysbio_ek2020/Tools/dorado-0.7.2-linux-x64/herro-v1
fastq_file=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_trimmed/trimmed_fastq_2/size_filtered/over10_CML_3064_bc01.fastq
output_dir=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_trimmed/trimmed_fastq_2/herro_corrected
dorado_bin=/home/data/fus_sysbio_ek2020/Tools/dorado-0.7.2-linux-x64/bin/dorado

base_name=$(basename "$fastq_file" .fastq)

#Run Dorado correct
${dorado_bin} correct \
    -x cpu \
    --infer-threads 32 \
    -m ${model_dna} \
    --threads 32 \
    "$fastq_file" > "${output_dir}/${base_name}.corrected.fasta"