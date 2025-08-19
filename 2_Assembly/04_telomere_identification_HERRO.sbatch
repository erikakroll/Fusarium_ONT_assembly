#!/bin/bash
##############################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#SBATCH --qos=short
#job name
#SBATCH --job-name=tidk
#job stdout file
#SBATCH --output=logs/tidk.out.%J
#job stderr file
#SBATCH --error=logs/tidk.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=0-01:00
#SBATCH --mem-per-cpu=2000
#SBATCH --nodes=1
#SBATCH --array=1-15
############################################
######  ml statements
ml Miniconda3/23.9.0-0
#####################################

BASE_DIR="/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/HERRO_Hifiasm_all"
STRAIN=$(sed -n "${SLURM_ARRAY_TASK_ID}p" strain_list.txt)
STRAIN_DIR="${BASE_DIR}/${STRAIN}"


cd "${STRAIN_DIR}"

/home/data/fus_sysbio_ek2020/Tools/gfatools/gfatools gfa2fa "over10.HERRO.${STRAIN}.asm.bp.p_ctg.gfa" > "${STRAIN}.p_ctg.fasta"

source activate /home/data/fus_sysbio_ek2020/conda_envs/tidk

tidk search --string TTAGGG --output "TTAGGG.${STRAIN}" --dir "${STRAIN_DIR}"  "${STRAIN}.p_ctg.fasta"

tidk plot --tsv "TTAGGG.${STRAIN}_telomeric_repeat_windows.tsv" --output "TTAGGG.${STRAIN}"




