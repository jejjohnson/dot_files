#!/bin/bash

#SBATCH --job-name=jlab_gpu         # name of job
#SBATCH --account=cli@v100          # GPU account budget
#SBATCH -C v100-32g                 # V100 GPU + 32 GBs RAM
#SBATCH --qos=qos_gpu-t3            # Short Duration 
#SBATCH --export=ALL
#SBATCH --nodes=1                   # we request one node
#SBATCH --ntasks-per-node=1         # with one task per node (= number of GPUs here)
#SBATCH --gres=gpu:1                # number of GPUs (1/4 of GPUs)
#SBATCH --cpus-per-task=10          # number of cores per task (1/4 of the 4-GPUs node)
#SBATCH --hint=nomultithread        # hyperthreading is deactivated
#SBATCH --time=10:00:00             # maximum execution time requested (HH:MM:SS)
#SBATCH --output=/linkhome/rech/genige01/uvo53rl/workdir/logs/slurm/logs/jlab_gpu.out    # name of output file
#SBATCH --error=/linkhome/rech/genige01/uvo53rl/workdir/logs/slurm/errs/jlab_gpu.err     # name of error file (here, in common with the output file)

# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
cluster="dahu_ciment"
port=3213

# get the information for ssh
squeue -u $USER -h | grep jlab_gpu | awk '{print $NF}' > $SLURMDIR/jobs/jlab_gpu.node
hostname -I | awk '{print $1}' > $SLURMDIR/jobs/jlab_gpu.ip
whoami > $SLURMDIR/jobs/jlab_gpu.user

# # cleans out the modules loaded in interactive and inherited by default
module purge

# loading of modules
module load git
module load cuda/11.2
source activate jlab

# echo of launched commands
set -x

# code execution
#jupyter-lab --no-browser --port=${port}
idrlab --notebook-dir=/gpfswork/rech/cli/uvo53rl