#!/bin/bash
# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
cluster="megatron"
port=3006

# print tunneling instructions jupyter-log
echo -e "
Command to create ssh tunnel:
ssh -N -f -L ${port}:localhost:${port} ${cluster}

Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)
"

# load modules or conda environments here
source activate jupyter

# Run Jupyter
jupyter-lab --no-browser --port=${port}