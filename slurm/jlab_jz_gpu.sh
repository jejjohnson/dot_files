#!/bin/bash

#SBATCH --job-name=jlab_gpu        # name of job
#SBATCH --account=cli@gpu
#SBATCH --export=ALL
#SBATCH --nodes=1                    # we request one node
#SBATCH --ntasks-per-node=1          # with one task per node (= number of GPUs here)
#SBATCH --gres=gpu:1                 # number of GPUs (1/4 of GPUs)
#SBATCH --cpus-per-task=10           # number of cores per task (1/4 of the 4-GPUs node)
#SBATCH --hint=nomultithread         # hyperthreading is deactivated
#SBATCH --time=10:00:00              # maximum execution time requested (HH:MM:SS)
#SBATCH --output=/linkhome/rech/genige01/uvo53rl/workdir/logs/jlab_gpu%j.out    # name of output file
#SBATCH --error=/linkhome/rech/genige01/uvo53rl/workdir/errs/jlab_gpu%j.out     # name of error file (here, in common with the output file)

# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
cluster="dahu_ciment"
port=3008

# get the information for ssh
squeue -u $USER -h | grep jlab_gpu | awk '{print $NF}' > $HOME/jlab_configs/jlab_gpu.node
hostname -I | awk '{print $1}' > $HOME/jlab_configs/jlab_gpu.ip
whoami > $HOME/jlab_configs/jlab_gpu.user

# # # cleans out the modules loaded in interactive and inherited by default 
# module purge

# Tunneling Info
echo -e "
node=${node}
user=${user}
cluster=${cluster}
port=${port}

Command to create ssh tunnel:
ssh -N -f -L ${port}:${node}:${port} ${user}@${cluster}

Command to create ssh tunnel through
ssh -N -f -L ${port}:localhost:${port} $

Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)
"
 
# loading of modules
module load git
module load cuda/10.2
source activate jlab
 
# echo of launched commands
set -x
 
# code execution
jupyter-lab --no-browser --port=${port} 