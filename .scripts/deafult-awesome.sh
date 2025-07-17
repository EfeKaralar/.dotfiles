#!/bin/bash

#
# This script loads back the default Awesome WM config in case something goes wrong.
#

# Safely copy the deafault Awesome config to the Current Awesome config
scp -vr ~/.config/awesome-backup ~/.config/awesome


# Default action
action_a() {
    echo "Loading back default Awesome config from ~/.config/awesome-default (default-action)"
    # Add your Action A code here
}

# Action B
action_b() {
    echo "Loading the currently worked on Awesome config from ~/.config/awesome-current"
    # Add your Action B code here
}

# Action C with config name input
action_c() {
    local config_name="$1"
    local file_path="~/.config/awesome-${config_name}"
    
    # Check if file exists
    if [[ ! -f "$file_path" ]]; then
        echo "Error: File '$file_path' does not exist" >&2
        exit 1
    fi
    
    echo "Loading the desired Awesome config from $filepath"
    # Add your Action C code here that works with the file
}

# Display usage information
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -b              Perform action B"
    echo "  -c <config>     Perform action C with specified config name"
    echo "  -h              Show this help message"
    echo ""
    echo "If no options are provided, action A will be performed by default."
}

# Parse command line arguments
while getopts "bc:h" opt; do
    case $opt in
        b)
            action_b
            exit 0
            ;;
        c)
            config_name="$OPTARG"
            if [[ -z "$config_name" ]]; then
                echo "Error: Config name cannot be empty" >&2
                usage
                exit 1
            fi
            action_c "$config_name"
            exit 0
            ;;
        h)
            usage
            exit 0
            ;;
        \?)
            echo "Error: Invalid option -$OPTARG" >&2
            usage
            exit 1
            ;;
        :)
            echo "Error: Option -$OPTARG requires an argument" >&2
            usage
            exit 1
            ;;
    esac
done

# If no flags were provided, perform default action A
action_a
