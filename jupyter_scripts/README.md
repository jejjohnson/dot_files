# Jupyter Notebook

This document explains how to start a Jupyter server on the VM and connect a Jupyter notebook to that server, all in VS Code. (The Jupyter notebook is also assumed to be hosted on the VM.)

1. Open VSCode and connect to the VM. 

2. Navigate to the repo and activate the glm_env environment. 

$ cd glmr-us
$ conda activate glm_env

3. Start a Jupyter server on the VLM. 

$ jupyter notebook

4. Open the Jupyter notebook you want to work on in your VSCode window. 

5. In the top right hand corner of the Jupyter notebook window, there is an option to connect to a Jupyter server. Click on this button and in the top middle of the window, enter the link to the Jupyter server as it was printed when you started the server in step 3. 

6. You should now be connected to the Jupyter server on the VM and ready to start working. 

---

```bash
# JUPYTER NOTEBOOK STUFF
function jpt(){
    # Fires-up a Jupyter notebook by supplying a specific port
    conda activate jupyterlab
    jupyter-lab --no-browser --port=$1
}
```
