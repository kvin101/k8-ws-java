#!/bin/bash

# Log file
LOGFILE="docker_manager.log"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Log function
log() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" >> "$LOGFILE"
}

# Timer function
time_execution() {
    local start_time=$SECONDS
    "$@"
    local end_time=$SECONDS
    local duration=$((end_time - start_time))
    echo -e "${BLUE}Time taken: ${duration} seconds${NC}"
}

# Show options
show_options() {
    echo -e "${BLUE}==============================${NC}"
    echo -e "${GREEN} Docker Management Menu${NC}"
    echo -e "${BLUE}==============================${NC}"
    echo -e "${YELLOW}1. List all containers${NC}"
    echo -e "${YELLOW}2. Start containers${NC}"
    echo -e "${YELLOW}3. Stop containers${NC}"
    echo -e "${YELLOW}4. Remove containers${NC}"
    echo -e "${YELLOW}5. Execute command in containers${NC}"
    echo -e "${YELLOW}6. View logs of containers${NC}"
    echo -e "${YELLOW}7. List all networks${NC}"
    echo -e "${YELLOW}8. Create a new network${NC}"
    echo -e "${YELLOW}9. Remove a network${NC}"
    echo -e "${YELLOW}10. Exit${NC}"
    echo -e "${BLUE}==============================${NC}"
}

# Read input on the same line
read_input() {
    read -p "$(echo -e "${GREEN}$1 ${NC}")" input
    echo "$input"
}

# Main menu function
main() {
    show_options
    choice=$(read_input "Enter your choice (1-10):")
    case $choice in
        1) list_containers ;;
        2) start_containers ;;
        3) stop_containers ;;
        4) remove_containers ;;
        5) exec_into_containers ;;
        6) view_logs ;;
        7) list_networks ;;
        8) create_network ;;
        9) remove_network ;;
        10) exit_script ;;
        *) echo -e "${RED}Invalid choice, please try again.${NC}"; sleep 2; main ;;
    esac
}

# Functions for each operation
list_containers() {
    echo -e "${YELLOW}Listing all containers...${NC}"
    log "Listing all containers"
    time_execution docker ps -a
    pause_and_return
}

start_containers() {
    containers=$(read_input "Enter container IDs or names to start (space-separated):")
    log "Starting containers: $containers"
    for container in $containers; do
        time_execution docker start "$container"
        echo -e "${GREEN}Container $container started.${NC}"
    done
    pause_and_return
}

stop_containers() {
    containers=$(read_input "Enter container IDs or names to stop (space-separated):")
    log "Stopping containers: $containers"
    for container in $containers; do
        time_execution docker stop "$container"
        echo -e "${GREEN}Container $container stopped.${NC}"
    done
    pause_and_return
}

remove_containers() {
    containers=$(read_input "Enter container IDs or names to remove (space-separated):")
    log "Removing containers: $containers"
    for container in $containers; do
        time_execution docker rm "$container"
        echo -e "${GREEN}Container $container removed.${NC}"
    done
    pause_and_return
}

exec_into_containers() {
    containers=$(read_input "Enter container IDs or names to execute into (space-separated):")
    command=$(read_input "Enter command to execute (e.g., bash):")
    log "Executing '$command' in containers: $containers"
    for container in $containers; do
        time_execution docker exec -it "$container" "$command"
        echo -e "${GREEN}Executed '$command' in container $container.${NC}"
    done
    pause_and_return
}

view_logs() {
    containers=$(read_input "Enter container IDs or names to view logs (space-separated):")
    log "Viewing logs for containers: $containers"
    for container in $containers; do
        time_execution docker logs "$container"
        echo -e "${GREEN}Logs for container $container displayed.${NC}"
    done
    pause_and_return
}

list_networks() {
    echo -e "${YELLOW}Listing all networks...${NC}"
    log "Listing all networks"
    time_execution docker network ls
    pause_and_return
}

create_network() {
    network_name=$(read_input "Enter network name to create:")
    log "Creating network $network_name"
    time_execution docker network create "$network_name"
    echo -e "${GREEN}Network $network_name created.${NC}"
    pause_and_return
}

remove_network() {
    network_name=$(read_input "Enter network name to remove:")
    log "Removing network $network_name"
    time_execution docker network rm "$network_name"
    echo -e "${GREEN}Network $network_name removed.${NC}"
    pause_and_return
}

exit_script() {
    echo -e "${RED}Exiting script. Goodbye!${NC}"
    log "Exited script"
    exit 0
}

# Utility function to pause and return to the main menu
pause_and_return() {
    echo -e "${BLUE}Press any key to return to the main menu...${NC}"
    read -n 1 -s
    main
}
