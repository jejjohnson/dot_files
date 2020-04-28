
```bash
ipython profile create
```

Put this in the following files:

* `$HOME/.ipython/profile_default/ipython_kernel_config.py`
* `$HOME/.ipython/profile_default/ipython_config.py`

```bash
c.InteractiveShellApp.code_to_run = [
    '%load_ext autoreload',
    '%autoreload 2'
]
```