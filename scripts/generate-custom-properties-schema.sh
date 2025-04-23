#!/bin/bash

generate_custom_props_file() {

    while getopts ":ho:r:n:" opt; do
        case $opt in
            o) ORG="$OPTARG" ;;
            n) NAME="$OPTARG" ;;
            h) echo "Usage: generate_custom_props_file [-h] -o ORG [-n FILENAME]"; return 0 ;;
            \?) echo "Invalid option: -$OPTARG" >&2; return 1 ;;
            :) echo "Option -$OPTARG requires an argument." >&2; return  2;;
        esac
    done

    if [[ -z "${ORG}" ]]; then
        echo "Error: Organization must be specified." >&2
        return 3
    fi

    NAME=${NAME:-"custom_props.json"}

    echo "{" > "${NAME}"
    echo "  \"properties\":" >> "${NAME}"
    gh api /orgs/"${ORG}"/properties/schema | jq -r 'del(.[]|.["url","source_type"])' >> "${NAME}"
    echo "}" >> "${NAME}"

    cat "${NAME}" | jq . > custom_props.json.tmp
    mv custom_props.json.tmp "${NAME}"
}

generate_custom_props_file "$@"

