#!/bin/bash
#################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#SBATCH --qos=medium
#job name
#SBATCH --job-name=polypolish
#job stdout file
#SBATCH --output=logs/polypolish.out.%J
#job stderr file
#SBATCH --error=logs/polypolish.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=1-00:00
#SBATCH --mem=20G
###########################################################
############## module load statements #########################

ml Miniconda3


source activate /home/data/fus_sysbio_ek2020/conda_envs/mamba

eval "$(mamba shell hook --shell bash)"

mamba activate /home/data/fus_sysbio_ek2020/conda_envs/polypolish

polypolish polish CML_3064_T2T.fasta CML_3064_T2T.mapped.sam > CML_3064_T2T_polished.fasta