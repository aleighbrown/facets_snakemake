#!/bin/bash
module load R
module load samtools
module load snakemake

sbcmd="sbatch --cpus-per-task={threads}"
sbcmd+=" --time=24:00:00 --partition={cluster.partition}"
sbcmd+=" {cluster.extra}"

snakemake -s facets.snakefile -pr --keep-going --local-cores $SLURM_CPUS_PER_TASK \
    --jobs 10 --nolock --cluster-config cluster.yaml --cluster "$sbcmd" \
    --latency-wait 120 all
