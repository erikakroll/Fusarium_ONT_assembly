#!/bin/bash
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#SBATCH --qos=medium
#job name
#SBATCH --job-name=minimap2
#job stdout file
#SBATCH --output=logs/minimap2.out.%J
#job stderr file
#SBATCH --error=logs/minimap2.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=0-10:00
#SBATCH --mem=10G
#SBATCH --array=0-15   # adjust based on number of strains

module load R/4.3.3-gfbf-2023b

REFERENCE="/home/data/fus_sysbio_ek2020/EK_fg_pangenome/CML3066.v2_assembly/assembly/CML3066_reference.fna"


BASE_DIR="/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/HERRO_Hifiasm_all"
STRAIN=$(sed -n "${SLURM_ARRAY_TASK_ID}p" strain_list.txt)
OUT_DIR="${BASE_DIR}/${STRAIN}/dotplots"
OUTNAME="CML3066_${STRAIN}_minimap2.paf"

mkdir -p "$OUT_DIR"

cd "${OUT_DIR}"

echo "Running minimap3 for ${STRAIN}"

export R_DEFAULT_DEVICE="png"

/home/data/fus_sysbio_ek2020/Tools/minimap2/minimap2 -x asm5 -t 8 "$REFERENCE" "../${STRAIN}.p_ctg.fasta" > "$OUTNAME"


/home/data/fus_sysbio_ek2020/Tools/paf2dotplot/paf2dotplot.r -f -b "$OUTNAME"