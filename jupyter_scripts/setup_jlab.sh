conda activate jlab

# generate config file
jupyter notebook --generate-config

# specify no browser
echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py

# specify to listen to any port
echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py

