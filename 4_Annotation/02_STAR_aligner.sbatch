#!/bin/bash
#####################################################################
#Email notification
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --partition=standard
#SBATCH --qos=medium
#job name
#SBATCH --job-name=STAR
#SBATCH --cpus-per-task=20
#job stdout file
#SBATCH --output=logs/STAR.out.%J
#job stderr file
#SBATCH --error=logs/STAR.err.%J
#maximum job time in D-HH:MM
#SBATCH --time=0-05:00
#SBATCH --mem=30G
##################################################################################
######## module load statements ###################

ml STAR/2.7.11a-GCC-12.3.0

# Config
# Define the working directory and input file pattern
masked_fasta_file=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/CML3064_HERRO_Chr4_telo.fixed.T2T.fasta.masked
genomedir_STAR_DIR=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/
SAMPLES_DIR=/home/data/fus_sysbio_ek2020/Transcriptomic_Datasets/Dilks_invitro/     # Directory containing *_1.fq.gz and *_2.fq.gz
OUTDIR=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_annotation/RNA_seq/CML3064/           # Where to store individual STAR output folders
THREADS=10

# Index the genome
STAR --runMode genomeGenerate \
     --genomeDir $genomedir_STAR_DIR \
     --genomeFastaFiles $masked_fasta_file \
     --runThreadN 20 \
     --genomeSAindexNbases 12 


# Loop over all *_1.fq.gz files in samples directory
for READ1 in "$SAMPLES_DIR"/PH1*_1.fq.gz; do
    SAMPLE_NAME=$(basename "$READ1" _1.fq.gz)
    READ2="$SAMPLES_DIR/${SAMPLE_NAME}_2.fq.gz"

    # Check for mate file
    if [[ ! -f "$READ2" ]]; then
        echo "Missing pair for $SAMPLE_NAME — skipping."
        continue
    fi

    # Define output subdirectory
    SAMPLE_OUTDIR="${OUTDIR}/${SAMPLE_NAME}"
    mkdir -p "$SAMPLE_OUTDIR"

    echo "Running STAR for sample: $SAMPLE_NAME"

    STAR \
        --genomeDir "$genomedir_STAR_DIR" \
        --readFilesIn "$READ1" "$READ2" \
        --readFilesCommand zcat \
        --outSAMstrandField intronMotif \
        --runThreadN "$THREADS" \
        --outSAMtype BAM SortedByCoordinate \
        --outReadsUnmapped Fastx \
        --twopassMode Basic \
        --limitBAMsortRAM 150000000000 \
        --outFileNamePrefix "${SAMPLE_OUTDIR}/${SAMPLE_NAME}_" \
        --outFilterScoreMinOverLread 0 \
        --outFilterMatchNmin 0 \
        --outFilterMatchNminOverLread 0
done
