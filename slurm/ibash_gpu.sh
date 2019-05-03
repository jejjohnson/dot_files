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
--nodelist=nodo17 \
--partition=LADON-GPU \
--gres=gpu:1 \
--nodes=1  \
--ntasks-per-node=1 \
--cpus-per-task=2 \
--time 100:00:00 \
--job-name eman-ibash-gpu \
--pty bash -i