#!/bin/bash

#OAR --name jlab_gpu
#OAR --project pr-data-ocean
#OAR -l /nodes=1,gpudevice=1,walltime=10:00:00
#OAR --stdout /home/johnsonj/logs/jupyterlab_gpu.log
#OAR --stderr /home/johnsonj/errs/jupyterlab_gpu.log


# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
cluster="dahu_ciment"
port=3008

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
source activate jlab

jupyter lab --no-browser --ip=0.0.0.0 --port=${port}

