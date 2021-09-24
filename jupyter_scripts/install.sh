conda env create --name jlab -f jupyterlab.yml

# activate environment
conda activate jupyterlab

# Install jupyter lab extensions
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install @bokeh/jupyter_bokeh
jupyter labextension install @jupyterlab/toc
jupyter labextension install @jupyterlab/server-proxy
jupyter labextension install dask-labextension
jupyter labextension install @pyviz/jupyterlab_pyviz
jupyter labextension install @lckr/jupyterlab_variableinspector

# Enable
jupyter serverextension enable --py nbserverproxy

# Update all
jupyter labextension --update --all