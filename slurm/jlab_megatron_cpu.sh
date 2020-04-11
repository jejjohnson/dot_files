#!/bin/bash
# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
cluster="megatron"
port=3006

# print tunneling instructions jupyter-log
echo -e "
# Tunneling Info
node=${node}
user=${user}
cluster=${cluster}
port=${port}

Command to create ssh tunnel:
ssh -N -f -L ${port}:${node}:${port} ${user}@${cluster}.uv.es

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