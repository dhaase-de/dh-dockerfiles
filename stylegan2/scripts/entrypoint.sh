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
    echo "  dataset_tool            Run stylegan2's script of the same name"
    echo "  help                    Show this help and exit"
    echo "  pretrained_networks     Run stylegan2's script of the same name"
    echo "  projector               Run stylegan2's script of the same name"
    echo "  run_generator           Run stylegan2's script of the same name"
    echo "  run_metrics             Run stylegan2's script of the same name"
    echo "  run_projector           Run stylegan2's script of the same name"
    echo "  run_training            Run stylegan2's script of the same name"
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
if [[ "$COMMAND" == "dataset_tool" || "$COMMAND" == "pretrained_networks" || "$COMMAND" == "projector" || "$COMMAND" == "run_generator" || "$COMMAND" == "run_metrics" || "$COMMAND" == "run_projector" || "$COMMAND" == "run_training" ]]; then
    BIN="$COMMAND.py"
elif [[ "$COMMAND" == "help" ]]; then
    print_help
    exit 0
else
    print_unknown_command
    print_help
    exit 1
fi

# run command and pass all arguments to it
cd /home/lib/stylegan2
python "$BIN" "$@"
