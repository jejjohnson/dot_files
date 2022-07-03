

# SHOW JOBS
function show_jobs(){
    squeue -u $USER
}

function show_all_jobs(){
    squeue
}


# KILL ALL JZ JOBS
function kill_job(){
    job=${1:-"jlab"}
    squeue -u $USER | awk $job | tail -n+2 | xargs scancel
}

# KILL ALL JZ JOBS
function kill_jobs_all(){
    port=${1:-3210}
    squeue -u $USER | awk '{print $1}' | tail -n+2 | xargs scancel
}