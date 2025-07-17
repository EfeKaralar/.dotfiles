#!/bin/bash

#
# This script loads back the default Awesome WM config in case something goes wrong.
#



# Default action
default() {
    echo "Loading back default Awesome config from ~/.config/awesome-default (default-action)"
    scp -vr ~/.config/awesome-backup ~/.config/awesome
}

# Action B
current() {
    echo "Loading the currently worked on Awesome config from ~/.config/awesome-current"
    scp -vr ~/.config/awesome-current ~/.config/awesome
}

# Action C with config name input
load() {
    local config_name="$1"
    local file_path="~/.config/awesome-${config_name}"

    # Check if file exists
    if [[ ! -f "$file_path" ]]; then
        echo "Error: File '$file_path' does not exist" >&2
        exit 1
    fi

    echo "Loading the desired Awesome config from $filepath"
    # Add your Action C code here that works with the file
    scp -vr $file_path ~/.config/awesome
}

# Display usage information
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -c              Loading back currently worked on Awesome config from ~/.config/awesome-current"
    echo "  -l <config>     Loading back default Awesome config from ~/.config/awesome-<config>"
    echo "  -h              display this message"
    echo ""
    echo "If no options are provided, script will load the awesome-default config performed by default."
}

# Parse command line arguments
while getopts "cl:h" opt; do
    case $opt in
        c)
            current
            exit 0
            ;;
        l)
            config_name="$OPTARG"
            if [[ -z "$config_name" ]]; then
                echo "Error: Config name cannot be empty" >&2
                usage
                exit 1
            fi
            load "$config_name"
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
default
