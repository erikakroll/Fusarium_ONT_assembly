#!/bin/bash
#SBATCH --job-name=BUSCO         # Job name
#SBATCH --partition=standard     # Specify the partition/queue
#SBATCH --mail-user=erika.kroll@rothamsted.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1                # Number of nodes
#SBATCH --ntasks=1               # Total number of tasks
#SBATCH --cpus-per-task=4        # Number of CPU cores per task 
#SBATCH --mem=16G                # Total memory per node
#SBATCH --time=2-00:00:00        # Time limit (2 days)
#SBATCH --output=logs/busco_%A_%a.out   # Standard output
#SBATCH --error=logs/busco_%A_%a.err    # Standard error
#SBATCH --qos=medium
###############################################################################

# Load apptainer
module load apptainer

transcript_file=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_annotation/CML3064/lift_off/fgCML3066LiftoffTofgCML3064.transcripts.fa


out_dir=/home/data/fus_sysbio_ek2020/EK_fg_pangenome/Nanopore_annotation/CML3064/BUSCO
busco_db_path=$HOME/busco_database

cp ${transcript_file} . 

 # Run BUSCO
apptainer exec /home/data/hpc_resources/sif_files/busco/busco_5.7.1.sif busco \
          -i braker.transcripts.fa \
          -m transcriptome \
          -l hypocreales_odb10 \
          -o CML_3064_liftoff \
          -c ${SLURM_CPUS_PER_TASK} -f \
		  --offline --download_path ${busco_db_path} 