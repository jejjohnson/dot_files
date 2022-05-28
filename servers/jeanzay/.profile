# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/gpfswork/rech/cli/uvo53rl/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/gpfswork/rech/cli/uvo53rl/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/gpfswork/rech/cli/uvo53rl/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/gpfswork/rech/cli/uvo53rl/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# CHANGE CORE DIRECTORY

# cd /gpfswork/rech/cli/uvo53rl

function srun_cpu(){
    cores={$1:-16}
    # go to work directory
    cd $WORKDIR &
    # do srun
    srun --account=cli@cpu --nodes=1 --ntasks-per-node=1 --cpus-per-task=$cores --hint=nomultithread --time=08:00:00 --pty bash
}

function srun_gpu(){
    # go to work directory
    cd $WORKDIR &
    # do srun
    srun --pty --account=cli@v100 --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 --gres=gpu:1 --hint=nomultithread --time=08:00:00 bash
}

function jlab(){
    # activate environment
    conda activate jlab &
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

# CUSTOM PATHS
export HOMEDIR=$HOME
export WORKDIR=/gpfswork/rech/cli/uvo53rl/
export LOGDIR=$WORKDIR/logs
export SLURMDIR=$WORKDIR/logs/slurm
export WANDBDIR=$WORKDIR/logs/wandb