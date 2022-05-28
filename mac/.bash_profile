function show_all_background_ssh(){
    ps aux | grep ssh | grep "localhost"
}
function kill_background_ssh(){
    ps aux | grep ssh | grep "{$1}:localhost" | awk '{print $2}' | xargs kill
}
function kill_all_background_ssh(){
    ps aux | grep ssh | grep "localhost" | awk '{print $2}' | xargs kill
}