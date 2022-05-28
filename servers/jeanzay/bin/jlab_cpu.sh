#!/bin/bash

#SBATCH --job-name=jlab_cpu         # name of job
#SBATCH --account=cli@cpu           # account name
#SBATCH --partition=prepost         # partition for pre-post processing
#SBATCH --export=ALL                # export everything
#SBATCH --nodes=1                   # we request one node
#SBATCH --ntasks-per-node=1         # with one task per node (= number of GPUs here)
#SBATCH --cpus-per-task=32          # number of cores per task (1/4 of the 4-GPUs node)
#SBATCH --time=10:00:00              # maximum execution time requested (HH:MM:SS)
#SBATCH --output=/linkhome/rech/genige01/uvo53rl/workdir/logs/slurm/logs/jlab_cpu.out    # name of output file
#SBATCH --error=/linkhome/rech/genige01/uvo53rl/workdir/logs/slurm/errs/jlab_cpu.err     # name of error file (here, in common with the output file)

# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
cluster="dahu_ciment"
port=3212

# get the information for ssh
squeue -u $USER -h | grep jlab_gpu | awk '{print $NF}' > $SLURMDIR/jobs/jlab_cpu.node
hostname -I | awk '{print $1}' > $SLURMDIR/jobs/jlab_cpu.ip
whoami > $SLURMDIR/jobs/jlab_cpu.user

# # cleans out the modules loaded in interactive and inherited by default
module purge

# loading of modules
source activate jlab

# echo of launched commands
set -x

# code execution
#jupyter-lab --no-browser --port=${port}
idrlab --notebook-dir=/gpfswork/rech/cli/uvo53rl