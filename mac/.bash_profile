# add scripts
export PATH="/user/local/bin:$PATH"

# add personal scripts
export PATH=~/bin:$PATH

# add anaconda dist to file path
# export PATH="/Users/eman/anaconda3/bin:$PATH"  # commented out by conda initialize

# set CLICOLOR if you want ansi colors in iterm2
export CLICOLOR=1

# set colors to match iterm2 terminal colors
export TERM=xterm-256color

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/eman/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/eman/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/eman/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/eman/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# =============================
# SSHUTTLE SHENNANIGANS
# =============================
function run_sshuttle_jz(){
    sshuttle --dns -HN -r meom_cal1 130.84.132.0/24
}

run_sshuttle(){
    sshuttle --dns -vNr jean_zay $(ssh jean_zay 'cat $HOME/jlab_configs/alloc_gpu.ip')/32
}

sshuttle_jlab_gpu(){
    sshuttle --dns -vNr jean_zay $(ssh jean_zay 'cat $HOME/jlab_configs/alloc_gpu.ip')/32
}

ssh_jz_compute_node(){
    ssh $(ssh jean_zay 'cat $HOME/jlab_configs/alloc_gpu.user')@$(ssh jean_zay 'cat $HOME/jlab_configs/alloc_gpu.ip')
}

run_sshuttle_jlab_cpu(){
    sshuttle --dns -vNr jean_zay $(ssh jean_zay 'cat $HOME/jlab_configs/alloc_cpu.ip')
}

# =============================
# SSH TUNNELING MANAGEMENT
# =============================
# syntatic sugar for launching ssh tunnel given a server and a port
function ssh_tunnel(){
    server="$1"
    port="$2"
    echo "server:" $1
    echo "port:" $2
    ssh -fN $server -L "$port":localhost:"$port"
}

# function to show all background ssh processes
# demo:
# > show_all_bg_ssh
#
function show_all_bg_ssh(){
    ps aux | grep ssh | grep "localhost"
}
# function to show background ssh processes given a localport
# demo:
# > show_bg_ssh 8888
#
function show_bg_ssh(){
    ps aux | grep ssh | grep $1
}

# function to kill background ssh process given a localport number
# demo:
# > kill_bg_ssh 8888
#
function kill_bg_ssh(){
    ps aux | grep ssh | grep $1 | awk '{print $2}' | xargs kill
}

# function to kill all background ssh processes
# demo:
# > kill_all_bg_ssh
#
function kill_all_bg_ssh(){
    ps aux | grep ssh | grep "localhost" | awk '{print $2}' | xargs kill
}

# =============================
# LOCAL JUPYTER LAB
# =============================

# Launch jlab
function jlab(){
    # set port (default)
    port=${1:-3210}
    # activate jupyter-lab
    conda activate jlab
    # Fires-up a Jupyter notebook by supplying a specific port
    jupyter-lab --no-browser --ip=0.0.0.0 --port=$port --notebook-dir=$HOME/code_projects
}

# launch a jlab session via tmux
function tmuxp_jlab(){
  tmuxp load $HOME/.tmuxp/jlab.yaml
}

# =============================
# MEOM CAL1
# =============================

# MEOM CAL1
function tmuxp_jlab_cal1(){
  tmuxp load $HOME/.tmuxp/jlab_cal1.yaml
}

# KILL ALL CAL1 JOBS
function kill_all_jobs_cal1(){
    ssh meom_cal1 | ps aux | grep ssh | grep "localhost" | awk '{print $2}' | xargs scancel
}

# =============================
# GRICAD
# =============================

# GRICAD (CPU)
function tmuxp_jlab_gricad(){
  tmuxp load $HOME/.tmuxp/jlab_gricad.yaml
}

# GRICAD (GPU)
function tmuxp_jlab_gricad_gpu(){
  tmuxp load $HOME/.tmuxp/jlab_gricad_gpu.yaml
}

# KILL ALL JZ JOBS
function kill_all_jobs_gricad(){
    ssh jean_zay | ps aux | grep ssh | grep "localhost" | awk '{print $2}' | xargs scancel
}


# =============================
# JEAN ZAY
# =============================

# JEAN-ZAY (CPU)
function tmuxp_jlab_jz(){
  tmuxp load $HOME/.tmuxp/jlab_jz.yaml
}

# JEAN-ZAY (GPU)
function tmuxp_jlab_jz_gpu(){
  tmuxp load $HOME/.tmuxp/jlab_jz_gpu.yaml
}

# KILL ALL JZ JOBS
function kill_all_jobs_jz(){
    ssh jean_zay | ps aux | grep ssh | grep "localhost" | awk '{print $2}' | xargs scancel
}
