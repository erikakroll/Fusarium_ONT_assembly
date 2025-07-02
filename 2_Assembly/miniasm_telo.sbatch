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

ml SAMtools/1.18-GCC-12.3.0
module load apptainer


cd /home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_assembly/Hifiasm/


#samtools faidx CML_3064_T2T.fasta ptg000005l:7919119-8118443 > CML_3064_T2T_ptg000005l:7919119-8118443.fa

#samtools view -b T2T_CML3064_aligned_HERRO.sorted.bam ptg000005l:7919119-8118443 > herro_ptg000005l:7919119-8118443.bam
#samtools fastq herro_ptg000005l:7919119-8118443.bam > herro_ptg000005l:7919119-8118443.fastq

/home/data/fus_sysbio_ek2020/Tools/minimap2/minimap2 -x ava-pb -t 8 herro_ptg000005l:7919119-8118443.fastq herro_ptg000005l:7919119-8118443.fastq > overlaps.herro_ptg000005l:7919119-8118443.paf


/home/data/fus_sysbio_ek2020/Tools/miniasm/miniasm -f herro_ptg000005l:7919119-8118443.fastq overlaps.herro_ptg000005l:7919119-8118443.paf > herro_ptg000005l:7919119-8118443.assembly.gfa

awk '/^S/{print ">"$2"\n"$3}' herro_ptg000005l:7919119-8118443.assembly.gfa > herro_ptg000005l:7919119-8118443.assembly.fasta

apptainer exec /home/data/hpc_resources/sif_files/quast/quast_5.2.0.sif quast.py herro_ptg000005l:7919119-8118443.assembly.fasta -o  quast_results/ --fungus -k

/home/data/fus_sysbio_ek2020/Tools/minimap2/minimap2 -x asm5 -t 8  CML_3064_T2T.fasta herro_ptg000005l:7919119-8118443.assembly.fasta > CML_3064_T2T_vs_herro_ptg000005l.paf

samtools faidx CML_3064_T2T.fasta ptg000005l:1-7820470 > ptg000005l_left.fa

samtools faidx herro_ptg000005l:7919119-8118443.assembly.fasta utg000001l:5-297844 > utg_utg000001l.fa

tail -n +2 utg_utg000001l.fa > utg_utg000001l._noheader.fa

sed -i 's/^>.*/>ptg000005l_corrected/' ptg000005l_left.fa

cat ptg000005l_left.fa utg_utg000001l._noheader.fa > corrected_ptg000005l.fa

cat CML_3064_hifi_chr1,2,3,mito.fasta corrected_ptg000005l.fa > CML_3064_corrected_telo.fa