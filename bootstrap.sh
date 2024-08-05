#!/usr/bin/env bash
set -a
source .env
set +a

command_exissts() {
    command -v "$1" >/dev/null 2>&1
}

check_prerequisites() {
    local missing=0

    for cmd in tofu packer ansible; do
        if ! command_exissts "$cmd"; then
            echo "Error: $cmd is not installed."
            missing=1
        fi
    done

    if [ $missing -eq 1 ]; then
        echo "Please install the missing prerequisistes and try again."
        exit 1
    fi

    echo "All prerequisites are installed."
}

deploy_homelab() {
    echo "Deploying homelab..."
    cd boxes/debian/
    echo -e "\033[0;32m[+] Building debian box baseline\033[0m"
    PACKER_LOG=1 packer build .
    echo "Homelab deployed successfully!"
}

teardown_homelab() {
    echo "Tearing down homelab..."
    
    # Delete VM
    DELETE_RESPONSE=$(curl -s -k -X DELETE -H "Authorization: PVEAPIToken=$PKR_VAR_proxmox_username=$PKR_VAR_proxmox_token" "${PKR_VAR_proxmox_url}/nodes/${NODE_NAME}/qemu/${VM_ID}?purge=1")

    echo "Homelab torn down successfully!"
}

check_prerequisites

case "$1" in
    "")
        deploy_homelab
        ;;
    clean)
        teardown_homelab
        ;;
    *)
        echo "Usage: $0 [clean]"
        echo "  If no argument is given, it will deploy the homelab."
        echo "  If 'clean' is given as an argument, it will teardown the homelab."
        exit 1
        ;;
esac
