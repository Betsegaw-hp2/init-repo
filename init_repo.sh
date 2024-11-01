#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 -a <account> -u <username> -r <repo> [-v] [-y]"
    echo "  -a <account>   GitHub account (account1 or account2)"
    echo "  -u <username>  GitHub username"
    echo "  -r <repo>      Repository name"
    echo "  -v             Enable verbose output"
    echo "  -y             Automatic yes to commit as the detected user"
    exit 1
}

# Initialize variables
VERBOSE=false
AUTO_YES=false

# Parse command-line arguments
while getopts "a:u:r:vy" opt; do
    case ${opt} in
        a )
            ACCOUNT=$OPTARG
            ;;
        u )
            USERNAME=$OPTARG
            ;;
        r )
            REPO=$OPTARG
            ;;
        v )
            VERBOSE=true
            ;;
        y )
            AUTO_YES=true
            ;;
        * )
            usage
            ;;
    esac
done

# Check if all required arguments are provided
if [ -z "$ACCOUNT" ] || [ -z "$USERNAME" ] || [ -z "$REPO" ]; then
    usage
fi

# Function to print verbose messages
verbose() {
    if [ "$VERBOSE" = true ]; then
        echo -e "\033[1;34m$1\033[0m"
    fi
}

# Function to print styled messages
print_message() {
    echo -e "\033[1;32m$1\033[0m"
}

# Initialize a new Git repository
verbose "Initializing a new Git repository..."
git init

# Create a new branch main
verbose "Creating a new branch 'main'..."
git branch -M main

# Add remote repository based on the account
if [ "$ACCOUNT" == "account1" ]; then
    verbose "Adding remote repository for account1..."
    git remote add origin git@github-account1:$USERNAME/$REPO.git
elif [ "$ACCOUNT" == "account2" ]; then
    verbose "Adding remote repository for account2..."
    git remote add origin git@github-account2:$USERNAME/$REPO.git
else
    echo "Unknown account: $ACCOUNT"
    exit 1
fi

# Get the user's name and email from Git configuration
USER_NAME=$(git config --get user.name)
USER_EMAIL=$(git config --get user.email)

# Function to prompt the user for confirmation
confirm_commit() {
    echo -e "\033[1;33mDetected committer: $USER_NAME <$USER_EMAIL>\033[0m"
    read -p "Do you want to commit as this user? (y/n) " response
    if [[ "$response" == "y" ]]; then
        return 0
    else
        return 1
    fi
}

# Check if automatic yes is enabled
if [ "$AUTO_YES" = true ]; then
    print_message "Automatic yes enabled. Committing as $USER_NAME <$USER_EMAIL>."
else
    # Prompt the user for confirmation
    if ! confirm_commit; then
        print_message "Let's set your local config."
        # Ask for new name and email
        read -p "Enter your user.name: " NEW_NAME
        read -p "Enter your user.email: " NEW_EMAIL

        # Set the new name and email in the local Git configuration
        git config --local user.name "$NEW_NAME"
        git config --local user.email "$NEW_EMAIL"

        # Update the user variables
        USER_NAME=$NEW_NAME
        USER_EMAIL=$NEW_EMAIL

        print_message "Committing as $USER_NAME <$USER_EMAIL>."
    fi
fi

# Add all files to the repository
verbose "Adding all files to the repository..."
git add .

# Commit the files
verbose "Committing the files..."
git commit -m "Initial commit"

# Push to the remote repository and set upstream
verbose "Pushing to the remote repository and setting upstream..."
git push --set-upstream origin main

# Success message
print_message "Repository initialized and pushed to GitHub successfully."

# Detailed output upon success if verbose is enabled
if [ "$VERBOSE" = true ]; then
    echo -e "\033[1;36mDetails:\033[0m"
    echo -e "\033[1;36m  Account: $ACCOUNT\033[0m"
    echo -e "\033[1;36m  Username: $USERNAME\033[0m"
    echo -e "\033[1;36m  Repository: $REPO\033[0m"
    echo -e "\033[1;36m  Remote URL: $(git remote get-url origin)\033[0m"
    echo -e "\033[1;36m  Branch: $(git branch --show-current)\033[0m"
    echo -e "\033[1;36m  Pushed by: $USER_NAME <$USER_EMAIL>\033[0m"
fi
