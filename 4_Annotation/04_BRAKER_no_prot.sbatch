#!/bin/bash
#####################################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#SBATCH --qos=medium
#job name
#SBATCH --job-name=BRAKER3
#SBATCH --cpus-per-task=30
#job stdout file
#SBATCH --output=logs/BRAKER3.out.%J
#job stderr file
#SBATCH --error=logs/BRAKER3.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=1-00:00
#SBATCH --mem=50G
##################################################################################
######## module load statements ###################

module load apptainer/1.2.5-1.el8

# Define variables
working_dir=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_annotation/CML3064/braker_output_invitro_noprot
BRAKER3_SIF=/home/data/hpc_resources/sif_files/braker3/braker3_3.0.8.sif
masked_fasta_file=CML3064_HERRO_Chr4_telo.fixed.T2T.fasta.masked
bam_files_dir=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_annotation/RNA_seq/CML3064/



cd /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_annotation/

apptainer exec -B $PWD:$PWD /home/data/hpc_resources/sif_files/braker3/braker3_3.0.8.sif bash -c "
cp -r /opt/Augustus/config/ /dev/shm/
export AUGUSTUS_CONFIG_PATH=/dev/shm/config
braker.pl --genome CML3064/CML3064_HERRO_Chr4_telo.fixed.T2T.fasta.masked --gff3 --threads 31 --workingdir ${working_dir} --rnaseq_sets_dirs ${bam_files_dir}  --rnaseq_sets_ids=PH1_72h_A_Aligned.sortedByCoord.out,PH1_72h_B_Aligned.sortedByCoord.out,PH1_72h_C_Aligned.sortedByCoord.out"