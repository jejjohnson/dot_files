#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=28
#SBATCH --time 200:00:00
#SBATCH --exclude=nodo17
#SBATCH --job-name jlab
#SBATCH --output /home/emmanuel/logs/jupyterlab-%J.log
#SBATCH --error /home/emmanuel/logs/jupyterlab-%J.log

# get arguments
echo "Total Arguments:" $#
echo "All Arguments values:" $@

args=("$@")

# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
cluster="erc"
port=${1: -3004}
port=3004

# print tunneling instructions jupyter-log
echo -e "
# Tunneling Info
node=${node}
user=${user}
cluster=${cluster}
port=${port}

Command to create ssh tunnel:
ssh -N -f -L ${port}:${node}:${port} ${user}@${cluster}.uv.es -p 2022

Command to create ssh tunnel through
ssh -N -f -L ${port}:localhost:${port} $

Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)
"

# load modules or conda environments here
module load Anaconda3
source activate jupyterlab

# Run Jupyter
jupyter-lab --no-browser --port=${port} 