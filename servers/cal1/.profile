# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


# =================
# CUSTOM PATHS
# =================
export HOME=/home/johnsonj
export WORK=/mnt/meom/workdir/johnsonj
export LOGDIR=$WORK/logs
export SLURMDIR=$WORK/logs/slurm
export WANDBDIR=$WORK/logs/wandb

# =================
# CUSTOM FUNCTIONS
# =================

# Launch jlab
function jlab(){
    # set port (default)
    port=${1:-3211}
    # go to appropriate directory
    cd $WORK
    # activate jupyter-lab
    conda activate jlab
    # Fires-up a Jupyter notebook by supplying a specific port
    jupyter-lab --no-browser --ip=0.0.0.0 --port=$port
}

# Launch jlab via srun
function jlab_srun(){
    port=${1:-3211}
    # go to appropriate directory
    cd $WORK
    # activate conda environment with jlab
    conda activate jlab
    # run jupyterlab via srun
    srun --nodes=1 --mem=1600 --time=8:00:00 --account=python --job-name=jlab jupyter-lab --no-browser --port=$port --ip=0.0.0.0
}


# Launch jlab
function jlab_sbatch(){
    # Fires up JLab using sbatch
    sbatch jlab_sbatch.sh
    # prints
    cat $LOGDIR/slurm/logs/jlab.log
    # prints jlab
    cat $LOGDIR/slurm/errs/jlab.err
}

# KILL ALL CAL1 JOBS
function kill_all_jobs(){
    squeue -u $USER | awk '{print $1}' | tail -n+2 | xargs scancel
}

# ====================
# WANDB
# ====================
function pull_wandb_changes(){
    rsync -avxH jean_zay:/gpfswork/rech/cli/uvo53rl/logs/wandb/ $WORK/logs/wandb/
}
function push_wandb_changes(){
    rsync -avxH $WORK/logs/wandb/ jean_zay:/gpfswork/rech/cli/uvo53rl/logs/wandb/
}
function sync_wandb_changes(){
    wandb sync $WORK/logs/wandb/
}
function sync_wandb_changes_offline(){
    wandb sync --include-offline $WORK/logs/wandb/offline-*
}


#!/bin/bash#!/bin/bash
MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh"
MINICONDA_PREFIX="$WORK/miniconda3"

# =======================
# CONDA INSTALLATION
# =======================
install_miniconda(){
  if [ ! -d $SCRATCH/miniconda3 ]; then
    echo "Installing Miniconda"
    wget $MINICONDA_URL -O $WORK/downloads/miniconda.sh
    bash $WORK/downloads/miniconda.sh -b -p $MINICONDA_PREFIX
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
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/jupyter_scripts/jupyterlab.yml -O $WORK/downloads/jlab.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORK/downloads/jlab.yaml
}

install_mamba_torch(){
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/conda/linux/torch_linux_py39.yaml -O $WORK/downloads/torch_py39.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORK/downloads/torch_py39.yaml
}

install_mamba_jax(){
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/conda/linux/jax_linux_py39.yaml -O $WORK/downloads/jax_py39.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORK/downloads/jax_py39.yaml
}

install_mamba_jaxtorch(){
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/conda/jaxtorch_linux_py39.yaml -O $WORK/downloads/jaxtorch_py39.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORK/downloads/jaxtorch_py39.yaml
}

install_mamba_jaxtf(){
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/jupyter_scripts/jaxtf_linux_py39.yaml -O $WORK/downloads/jaxtf_py39.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORK/downloads/jaxtf_py39.yaml
}

install_mamba_jaxtorchtf(){
  wget https://raw.githubusercontent.com/jejjohnson/dot_files/master/jupyter_scripts/jaxtorchtf_linux_py39.yaml -O $WORK/downloads/jaxtorchtf_py39.yaml
  eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"
  mamba env create -f $WORK/downloads/jaxtorchtf_py39.yaml
}


eval "$($MINICONDA_PREFIX/condabin/conda shell.bash hook)"