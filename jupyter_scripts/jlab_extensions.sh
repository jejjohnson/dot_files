#!/bin/bash

source activate jupyterlab


# Dask Lab Extension
jupyter labextension install dask-labextension

# NBServer Extension
jupyter serverextension enable --py nbserverproxy

# Variable Inspector
jupyter labextension install @lckr/jupyterlab_variableinspector

# Snippets
jupyter labextension install @quentinandre/jupyterlab_snippets

# Code Formatter
jupyter labextension install @ryantam626/jupyterlab_code_formatter
jupyter serverextension enable --py jupyterlab_code_formatter

# Git
jupyter labextension install @jupyterlab/git

# TOC
jupyter labextension install @jupyterlab/toc