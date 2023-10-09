# CHANGE CORE DIRECTORY

# cd /gpfswork/rech/cli/uvo53rl

# CUSTOM PATHS
export HOMEDIR=$HOME
export SCRATCHDIR=/gpfsscratch/rech/cli/uvo53rl/
export WORKDIR=/gpfswork/rech/cli/uvo53rl/
export LOGDIR=$SCRATCH/logs
export ERRDIR=$SCRATCH/errs
export WANDBDIR=$SCRATCH/wandb
export TBDIR=$SCRATCH/tensorboard
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
export CONDADIR=$SCRATCHDIR/miniconda3

function srun_cpu(){
    cores={$1:-16}
    # go to work directory
    cd $WORKDIR &
    # do srun
    srun --account=cli@cpu --nodes=1 --ntasks-per-node=1 --cpus-per-task=$cores --hint=nomultithread --time=02:00:00 --partition=prepost --pty bash
}

function srun_gpu(){
    # go to work directory
    cd $WORKDIR &
    # do srun
    srun --account=cli@v100 --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 --gres=gpu:1 --hint=nomultithread --partition=prepost --qos=qos_gpu-dev --time=02:00:00 --pty bash
}

function slloc_cpu(){
    cores=${1:-16}
    # go to work directory
    cd $WORKDIR &
    # do srun
    salloc --account=cli@cpu --nodes=1 --ntasks-per-node=1 --cpus-per-task=$cores --hint=nomultithread --time=02:00:00 --partition=prepost
}

function slloc_gpu(){
    # go to work directory
    cd $WORKDIR &
    # do srun
    salloc --account=cli@v100 --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 --gres=gpu:1 --hint=nomultithread --partition=prepost --qos=qos_gpu-dev --time=02:00:00
}

function jlab_srun(){
    # go to work directory
    cd $WORKDIR
    # do srun
    srun --pty --account=cli@cpu --nodes=1 --ntasks-per-node=1 --cpus-per-task=32 --hint=nomultithread --time=04:00:00 bash
    # activate environment
    conda activate jlab
    # run jlab
    idrlab --notebook-dir=$WORKDIR
}

function jlab_gpu_srun(){
    # go to work directory
    cd $WORKDIR
    # do srun
    srun --pty --account=cli@v100 --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 --gres=gpu:1 --hint=nomultithread --time=01:30:00 bash
    # activate environment
    conda activate jlab
    # run jlab
    idrlab --notebook-dir=$WORKDIR
}

allocate_node_test(){
    salloc --ntasks=1 --cpus-per-task=10 --gres=gpu:1 --hint=nomultithread -C v100-16g --qos=qos_gpu-dev -A cli@gpu --time=2:00:00 --job-name=repl_test
    squeue -u $USER -h | grep repl_test | awk '{print $NF}' > $HOME/jlab_configs/alloc_gpu.node
    ssh $(cat $HOME/jlab_configs/alloc_gpu.node) -o StrictHostKeyChecking=no
    hostname -I | awk '{print $1}' > $HOME/jlab_configs/alloc_gpu.ip
}

PATH="$HOME/.local/bin:$PATH"



# MODULES BY DEFAULT
module load git/2.31.1
module load github-cli/1.13.1
module load git-lfs/3.0.2
#module load anaconda-py3/2021.05

# ALIASES
alias show_jobs="squeue -u $USER"

#!/bin/bash#!/bin/bash
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh"
export MINICONDA_PREFIX=$SCRATCHDIR/miniconda3

# ========================
# WANDB
# ========================
function sync_wandb_changes(){
    wandb sync $WORKDIR/logs/wandb/*
}
function sync_wandb_changes_offline(){
    wandb sync --include-offline $WORKDIR/logs/wandb/offline-*
}

# =======================
# CONDA INSTALLATION
# =======================
install_miniconda(){
  if [ ! -d $SCRATCH/miniconda3 ]; then
    echo "Installing Miniconda"
    wget $MINICONDA_URL -O $WORKDIR/downloads/miniconda.sh
    bash $WORKDIR/downloads/miniconda.sh -b -p $MINICONDA_PREFIX
    # install mamba in base env
    install_mamba
    # install 'global' jupyterlab
    install_mamba_jlab
    # install pytorch
    install_mamba_torch
    # install jax
    install_mamba_jax
    # install jax+pytorch
    install_mamba_jaxtorch
    # install jax+tensorflow
    install_mamba_jaxtf
    # install jax+pytorch+tensorflow
    install_mamba_jaxtorchtf
  else
    echo "Miniconda already installed"
  fi
}

install_mamba(){
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  conda install -y mamba -c conda-forge
}

install_mamba_jlab(){
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/jupyter_scripts/jupyterlab.yml -O $WORKDIR/downloads/jlab.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORKDIR/downloads/jlab.yaml
}

install_mamba_torch(){
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/conda/linux/torch_linux_py39.yaml -O $WORKDIR/downloads/torch_py39.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORKDIR/downloads/torch_py39.yaml
}

install_mamba_jax(){
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/conda/linux/jax_linux_py39.yaml -O $WORKDIR/downloads/jax_py39.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORKDIR/downloads/jax_py39.yaml
}

install_mamba_jaxtorch(){
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/conda/jaxtorch_linux_py39.yaml -O $WORKDIR/downloads/jaxtorch_py39.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORKDIR/downloads/jaxtorch_py39.yaml
}

install_mamba_jaxtf(){
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/jupyter_scripts/jaxtf_linux_py39.yaml -O $WORKDIR/downloads/jaxtf_py39.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORKDIR/downloads/jaxtf_py39.yaml
}

install_mamba_jaxtorchtf(){
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/jupyter_scripts/jaxtorchtf_linux_py39.yaml -O $WORKDIR/downloads/jaxtorchtf_py39.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORKDIR/downloads/jaxtorchtf_py39.yaml
}


eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"