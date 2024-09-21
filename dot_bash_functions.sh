
#
# venv management
#
# Init python venvs created in the .local/venvs dir
export PYENV_HOME=$HOME/.local/venvs
if ! [ -d $PYENV_HOME ]; then
    mkdir -p $PYENV_HOME
fi

function chkarg() { if [ -z "$@" ]; then echo "${FUNCNAME[-1]} requires an venv name"; exit -1; else exit 0; fi }

function activate() {
    (chkarg $@)
    if [ -n "$VIRTUAL_ENV" ]; then
        deactivate
    fi
    source $PYENV_HOME/$@/bin/activate ;
}
function mkenv { (chkarg $@) && $(which python3) -m venv $PYENV_HOME/$@ ;}

function rmenv { 
    (chkarg $@)
    if [ "$?" -ne 0 ]; then
        return -1
    fi
    ACTIVE=""
    if [ "$( basename $VIRTUAL_ENV)" == "$@" ]; then
        deactivate
    fi
    echo "removing $@"
    $(which rm) -fr $PYENV_HOME/$@ ;
}

function lsenv { 
    ACTIVE=""
    if [ -n "$VIRTUAL_ENV" ]; then
        ACTIVE=$(basename $VIRTUAL_ENV)
    fi
    for d in $(ls -d $PYENV_HOME/* 2> /dev/null); do
        VENV_NAME=$(basename $d)
        if [ "$VENV_NAME" = "$ACTIVE" ]; then
            echo "* $VENV_NAME";
        else
            echo "  $VENV_NAME"
        fi
    done ;
}

#
# make my life easier
# 
#
function mgmt-ip() {
    if [ $# -eq 0 ]; then
        echo "Help message"
    fi
    for host in $@; do
        url="http://10.48.0.61/api/v1/devices/${host}/mgmt-ip"
        echo $(curl -sq $url | jq -r '.MGMT_IP' | cut -d\/ -f1)
    done
}

# monitor a file for the number of lines in it
function ccount {
    echo "Ctrl + c to quit"
    while true; do
        echo -en "$(wc -l $1)\r"
        sleep 5
    done
}


# log my ssh session in the current directory
function SSH() { 
    mkdir -p ~/.logs 2 > /dev/null; 
    date=
    ssh $1 | tee -a $PWD/logs/$1; 
}


# ping a host and ssh into it when it becomes available
symbols=( "| " "/ " "- " "\\" )
function p-ssh() {
    until ping -c1 -W1 $1 > /dev/null 2>&1; do
        for symbol in "${symbols[@]}"; do
            echo -ne "  $symbol Waiting on ${1} \r"
            sleep 1
        done
    done && ssh $1
}

function gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}

