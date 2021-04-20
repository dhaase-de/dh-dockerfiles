#!/bin/bash

# robust bash scripting
set -o errexit
set -o nounset

##
## 
##

function print_help() {
    echo "Usage: (docker run ...) <command> [arg1] [arg2] [...]"
    echo ""
    echo "Commands:"
    echo "  predict                 Run prediction (see DL-SR readme and file 'src/demo_predict.sh' for details)"
    echo "  train_DFCAN             Run training shell script (see DL-SR readme and file 'src/demo_train.sh' for details)"
    echo "  train_DFGAN             Run training shell script (see DL-SR readme and file 'src/demo_train.sh' for details)"
    echo "  shell                   Run interactive shell"
    echo "  help                    Show this help and exit"
    echo ""
}

function print_unknown_command() {
    echo "Error: unknown command '$COMMAND'"
    echo ""
}

##
## main
##

# get command
if [[ $# -eq 0 ]]; then
    # if no command is specified, print usage and exit
    COMMAND="help"
else
    # extract command from arguments
    COMMAND="$1"
    shift
fi

# map command to call
if [[ "$COMMAND" == "predict" || "$COMMAND" == "train_DFCAN" || "$COMMAND" == "train_DFGAN" ]]; then
    BIN="/usr/bin/python3 $COMMAND.py"
elif [[ "$COMMAND" == "shell" ]]; then
    BIN="/bin/bash"
elif [[ "$COMMAND" == "help" ]]; then
    print_help
    exit 0
else
    print_unknown_command
    print_help
    exit 1
fi

# run command and pass all arguments to it
cd /home/lib/DL-SR/src
$BIN "$@"
