#!/bin/bash

#SBATCH --job-name=jlab                     # name of job
#SBATCH --account=python                    # for statistics
#SBATCH --nodes=1                           # we ALWAYS request one node
#SBATCH --ntasks-per-node=1                 # number of tasks per node
#SBATCH --cpus-per-task=4                   # number of cpus per task
#SBATCH --time=8:00:00                      # maximum execution time requested (HH:MM:SS)
#SBATCH --mem=1600                          # the amount of memory requested
#SBATCH --output=/mnt/meom/workdir/johnsonj/logs/slurm/logs/jlab.log      # name of output file
#SBATCH --error=/mnt/meom/workdir/johnsonj/logs/slurm/errs/jlab.err       # name of error file

# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
cluster="ige-meom-cal1"
cluster_ssh="meom_cal1"
port=3211

# ==================
# Information 4 SSH
# ==================
# Get the compute node
squeue -u $USER -h | grep jlab | awk '{print $NF}' > $LOGDIR/slurm/jobs/jlab.node
# get the hostname
hostname -I | awk '{print $1}' > $LOGDIR/slurm/jobs/jlab.ip
# get the username
whoami > $LOGDIR/slurm/jobs/jlab.user

# Tunneling Info
echo -e "
node=${node}
user=${user}
cluster=${cluster}
port=${port}

Command to create ssh tunnel (manually):
ssh -N -f -L ${port}:${node}:${port} ${user}@${cluster}

Command to create ssh tunnel (ssh config):
ssh -N -f -L ${port}:${cluster_ssh}:${port} ${cluster_ssh}

Command to create ssh tunnel through
ssh -N -f -L ${port}:localhost:${port} $

Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)
"

# loading of modules
source activate jlab

# go into work directory
cd $WORKDIR

# echo of launched commands
set -x

# code execution
jupyter-lab --no-browser --port=${port} --ip=0.0.0.0