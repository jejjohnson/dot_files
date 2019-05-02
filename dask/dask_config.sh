jobqueue:

   slurm:
     name: dask-worker

     # Dask worker options
     cores: 28                 # Total number of cores per job
     memory: "200GB"                # Total amount of memory per job
     processes: 1                # Number of Python processes per job

     interface: null             # Network interface to use like eth0 or ib0
     death-timeout: 60           # Number of seconds to wait if a worker can not find a scheduler
     local-directory: null       # Location of fast local storage like /scratch or $TMPDIR

     # SLURM resource manager options
     queue: LADON
     project: null
     walltime: '00:30:00'
     extra: ""
     env-extra: []
     job-cpu: null
     job-mem: null
     job-extra: {}

distributed:
  worker:
    memory:
      target: false  # don't spill to disk
      spill: false  # don't spill to disk
      pause: 0.80  # pause execution at 80% memory use
      terminate: 0.95  # restart the worker at 95% use
