#!/bin/bash
# get tunneling info
node=$(hostname -s)
user=$(whoami)
cluster="erc"
port=3004

# load modules or conda environments here
XDG_RUNTIME_DIR=""
module load Anaconda3


srun \
--nodes=1  \
--ntasks-per-node=1 \
--cpus-per-task=28 \
--time 100:00:00 \
--exclude=nodo17 \
--job-name eman-ibash\
--pty bash -i
