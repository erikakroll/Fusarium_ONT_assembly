#!/bin/bash
#################################################
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

#############################################################
#module load statements

ml minimap2/2.26-GCCcore-12.3.0
ml SAMtools/1.18-GCC-12.3.0
ml SeqKit/2.2.0

cd /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/

READS=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_seq_trimmed/trimmed_fastq_2/herro_corrected/over10_CML_3064_bc01.corrected.fasta


# seqkit grep -p ptg000001l /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/HERRO_Hifi/ver10.nobloom.Herro.CML_3064_bc01.asm.bp.p_ctg.fasta > HERRO_ptg000001l.fasta

# seqkit grep -p ptg000005l /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/over10.Hifi.CML_3064_bc01.asm.bp.p_ctg.fasta > Hifi_ptg000005l.fasta 

# /home/data/fus_sysbio_ek2020/Tools/minimap2/minimap2 -x asm5 -t 8 Hifi_ptg000005l.fasta HERRO_ptg000001l.fasta > HERRO_vs_Hifi.paf

# samtools faidx /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/HERRO_Hifi/ver10.nobloom.Herro.CML_3064_bc01.asm.bp.p_ctg.fasta ptg000001l:1-13133 > HERRO_ptg000001l_left.fa

# samtools faidx /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/over10.Hifi.CML_3064_bc01.asm.bp.p_ctg.fasta ptg000005l:73026-8117292 > Hifiasm_ptg000005l_right.fa

# sed -i 's/^>.*/>ptg000005l_corrected/' HERRO_ptg000001l_left.fa

# tail -n +2 Hifiasm_ptg000005l_right.fa > Hifiasm_ptg000005l_right_nohead.fa

# cat HERRO_ptg000001l_left.fa Hifiasm_ptg000005l_right_nohead.fa > CML3064_HERRO_Chr4_telo.fasta


/home/data/fus_sysbio_ek2020/Tools/minimap2/minimap2 -ax map-pb CML3064_HERRO_Chr4_telo.fasta ${READS} | samtools sort -@ 8 -o CML3064_HERRO_Chr4_telo_aligned_HERRO.sorted.bam
samtools index CML3064_HERRO_Chr4_telo_aligned_HERRO.sorted.bam