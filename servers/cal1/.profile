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
export HOMEDIR=/home/johnsonj
export WORKDIR=/mnt/meom/workdir/johnsonj
export LOGDIR=$WORKDIR/logs
export SLURMDIR=$WORKDIR/logs/slurm
export WANDBDIR=$WORKDIR/logs/wandb

# =================
# CUSTOM FUNCTIONS
# =================

# Launch jlab
function jlab(){
    # set port (default)
    port=${1:-3211}
    # go to appropriate directory
    cd $WORKDIR
    # activate jupyter-lab
    conda activate jlab
    # Fires-up a Jupyter notebook by supplying a specific port
    jupyter-lab --no-browser --ip=0.0.0.0 --port=$port
}

# Launch jlab via srun
function jlab_srun(){
    port=${1:-3211}
    # go to appropriate directory
    cd $WORKDIR
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