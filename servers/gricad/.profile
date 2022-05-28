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

# ==================
# JOB KEY FILE
# ==================
export OAR_JOB_KEY_FILE=/home/johnsonj/.ssh/id_my_job_key

# ALIASES
alias jobs_check="oarstat -u johnsonj"
alias check_nodes="recap.py"
alias jobs_submit_bash="oarsub -S"
alias jobs_submit_interact="oarsub -I -l /nodes=1,walltime=2:00:00 --project pr-data-ocean"

# LANDING DIRECTORY
cd /bettik/johnsonj

ROOT_PATH="/applis"


CUDA_HOME=$ROOT_PATH/bigfoot/cuda/cuda-10.2
CUDA_UTILS=$ROOT_PATH/bigfoot/cuda/cuda-utils/-10.2
CUDA_EXTRAS=$CUDA_HOME/extras/CUPTI/lib64
export CUDA_HOME=$CUDA_HOME
export CUDADIR=$CUDA_HOME
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_EXTRAS:$CUDA_UTILS/lib64:$CUDA_HOME/lib64:$LD_LIBRARY_PATH
