#!/bin/bash

# User Management Script
# Supports create, delete, reset, list and help operations.

# Function to display help
show_help() {
    echo "Usage: $0 [OPTION]"
    echo "Options:"
    echo "  -c, --create    Create a new user"
    echo "  -d, --delete    Delete an existing user"
    echo "  -r, --reset     Reset user password"
    echo "  -l, --list      List all users and UIDs"
    echo "  -h, --help      Display help information"
}

# Function to create user
create_user() {
    read -rp "Enter username: " username

    if id "$username" &>/dev/null; then
        echo "Error: Username already exists!"
        return 1
    fi

    sudo useradd -m "$username"

    if [ $? -eq 0 ]; then
        echo "User $username created successfully."
        sudo passwd "$username"
    else
        echo "Error: User creation failed."
        return 1
    fi
}

# Function to delete user
delete_user() {
    read -rp "Enter username to delete: " username

    if ! id "$username" &>/dev/null; then
        echo "Error: User does not exist!"
        return 1
    fi

    if [ "$username" = "root" ]; then
        echo "Error: Root account cannot be deleted."
        return 1
    fi

    read -rp "Are you sure? (yes/no): " confirmation

    if [ "$confirmation" = "yes" ]; then
        sudo userdel "$username"

        if [ $? -eq 0 ]; then
            echo "User $username deleted successfully."
        else
            echo "Error: User deletion failed."
            return 1
        fi
    else
        echo "Deletion cancelled."
    fi
}

# Function to reset password
reset_password() {
    read -rp "Enter username: " username

    if ! id "$username" &>/dev/null; then
        echo "Error: User does not exist!"
        return 1
    fi

    echo "Enter new password for $username:"
    sudo passwd "$username"

    if [ $? -eq 0 ]; then
        echo "Password updated successfully for $username."
    else
        echo "Error: Password reset failed."
        return 1
    fi
}

# Function to list users and UIDs
list_users() {
    echo "Username                 UID"
    echo "----------------------------"

    awk -F: '{printf "%-24s %s\n", $1, $3}' /etc/passwd
}

# Main menu using command-line arguments
case "$1" in
    -c|--create)
        create_user
        ;;
    -d|--delete)
        delete_user
        ;;
    -r|--reset)
        reset_password
        ;;
    -l|--list)
        list_users
        ;;
    -h|--help)
        show_help
        ;;
    *)
        echo "Invalid option."
        show_help
        exit 1
        ;;
esac
