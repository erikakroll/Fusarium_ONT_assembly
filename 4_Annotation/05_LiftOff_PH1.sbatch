#!/bin/bash
#################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#job name
#SBATCH --job-name=liftOff
#job stdout file
#SBATCH --output=logs/liftOff.out.%J
#job stderr file
#SBATCH --error=logs/liftOff.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=1-00:00
#maximum memory of 6Gb
#SBATCH --mem-per-cpu=6000
#SBATCH --ntasks=1
#############################################################
module load Miniconda3
source activate liftoff
#############################################################

reference='/home/data/fus_sysbio_ek2020/EK_fg_pangenome/PH1/GCA_900044135.1_GZPH1RResV1_genomic.fna'
target='/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/CML3064_HERRO_Chr4_telo.fixed.T2T.fasta.masked'
gff='/home/data/fus_sysbio_ek2020/EK_fg_pangenome/PH1/GCA_900044135.1_GZPH1RResV1_genomic_with_ids.gtf'
FROMSTUB='REFORMAT_fgPH1'
TOSTUB='fgCML3064'
OUTDIR=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_annotation/CML3064/lift_off
 
liftoff \
-g ${gff} \
-o "${FROMSTUB}LiftoffTo${TOSTUB}.gff" \
-u "${FROMSTUB}LiftoffTo${TOSTUB}_nomap.txt" \
-dir ${OUTDIR} \
${target} ${reference}

#############################################################
#liftoff [-h] (-g GFF | -db DB) [-o FILE] [-u FILE] [-exclude_partial]
#               [-dir DIR] [-mm2_options =STR] [-a A] [-s S] [-d D] [-flank F]
#              [-V] [-p P] [-m PATH] [-f TYPES] [-infer_genes]
#               [-infer_transcripts] [-chroms TXT] [-unplaced TXT] [-copies]
#               [-sc SC] [-overlap O] [-mismatch M] [-gap_open GO]
#               [-gap_extend GE] [-polish] [-cds]
#               target reference
