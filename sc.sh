#!/bin/bash

# Service Status Check Script for Ubuntu Server
# Checks status of isc-dhcp-server, nfs-server, webmin, cockpit, and lighttpd

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check service status
check_service() {
    local service_name=$1
    local display_name=${2:-$service_name}
    
    if systemctl is-active --quiet "$service_name"; then
        echo -e "${GREEN}[RUNNING]${NC} $display_name"
    elif systemctl is-enabled --quiet "$service_name"; then
        echo -e "${YELLOW}[INACTIVE]${NC} $display_name (but enabled)"
    else
        echo -e "${RED}[STOPPED]${NC} $display_name"
    fi
}

# Main script
echo -e "\n${YELLOW}==== Service Status Check ====${NC}\n"

# Check each service
check_service "isc-dhcp-server" "ISC DHCP Server"
check_service "nfs-server" "NFS Server"
check_service "webmin" "Web-interface"
check_service "cockpit" "Cockpit"
check_service "lighttpd" "Lighttpd"

echo -e "\n${YELLOW}==== Additional Information ====${NC}"
echo -e "For more details about a service, run: ${YELLOW}sudo systemctl status <service>${NC}"
echo -e "To start a service: ${YELLOW}sudo systemctl start <service>${NC}"
echo -e "To enable a service: ${YELLOW}sudo systemctl enable <service>${NC}\n"

