# Init Repo Script

This script initializes a new Git repository, sets up the remote, pulls the latest changes, and pushes the initial commit. It also handles user configuration for commits and provides styled output for better readability.

## Introduction

The `init_repo.sh` script is designed to streamline the process of setting up a new Git repository and pushing the initial commit. It supports multiple GitHub accounts and provides options for verbose output and automatic confirmation.

## Usage

### Basic Usage

To use the script, run the following command:

```sh
./init_repo.sh -a <account> -u <username> -r <repo> [-v] [-y]
```

- `-a <account>`: Specify the GitHub account (e.g., `account1` or `account2`).
- `-u <username>`: Specify the GitHub username.
- `-r <repo>`: Specify the repository name.
- `-v`: Enable verbose output (optional).
- `-y`: Automatic yes to commit as the detected user (optional).

### Example

To initialize a repository for `account1` with verbose output and automatic yes:

```sh
./init_repo.sh -a account1 -u your_username -r your_repo -v -y
```

To initialize a repository for `account2` with verbose output and manual confirmation:

```sh
./init_repo.sh -a account2 -u your_username -r your_repo -v
```

## Setup

### Prerequisites

- Ensure you have Git installed on your system.
- Ensure you have SSH keys set up for your GitHub accounts.

### Setting Up SSH Keys

1. **Generate a New SSH Key**:
   - Open your terminal and generate a new SSH key for each GitHub account.

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
# Save the key as ~/.ssh/id_ed25519_account1
```

2. **Add the SSH Key to the SSH Agent**:
   - Start the SSH agent and add the new key.

```sh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_account1
```

3. **Add the SSH Key to GitHub**:
   - Copy the SSH public key and add it to your GitHub account.

```sh
cat ~/.ssh/id_ed25519_account1.pub
```
   - Go to GitHub, navigate to **Settings > SSH and GPG keys**, and add the new SSH key.

### Configuring SSH for Multiple Accounts

1. **Edit the SSH Config File**:
   - Open your `~/.ssh/config` file in a text editor.

```sh
nano ~/.ssh/config
```

2. **Add Configuration for Each Account**:
   - Add the following configuration for each GitHub account:

```sh
# ~/.ssh/config

# Account 1
Host github-account1
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_account1

# Account 2
Host github-account2
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_account2
```

### Testing SSH Connections

1. **Test Connection for Account 1**:

```sh
ssh -T git@github-account1
```

   - Expected output:

```sh
Hi username1! You've successfully authenticated, but GitHub does not provide shell access.
```

2. **Test Connection for Account 2**:

```sh
ssh -T git@github-account2
```

   - Expected output:

```sh
Hi username2! You've successfully authenticated, but GitHub does not provide shell access.
```

## Additional Information

### Setting Up Multiple Accounts

To set up multiple GitHub accounts, follow these steps:

1. **Generate SSH Keys for Each Account**:
   - Generate a new SSH key for each GitHub account.

```sh
ssh-keygen -t ed25519 -C "your_email_account1@example.com"
ssh-keygen -t ed25519 -C "your_email_account2@example.com"
```

2. **Add SSH Keys to the SSH Agent**:
   - Add the SSH keys to the SSH agent.

```sh
ssh-add ~/.ssh/id_ed25519_account1
ssh-add ~/.ssh/id_ed25519_account2
```

3. **Add SSH Keys to GitHub**:
   - Add the SSH public keys to the respective GitHub accounts.

4. **Configure SSH for Multiple Accounts**:
   - Edit the `~/.ssh/config` file to include the configurations for both accounts.

```sh
# ~/.ssh/config

# Account 1
Host github-account1
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_account1

# Account 2
Host github-account2
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_account2
```

5. **Test SSH Connections**:
   - Test the SSH connections to ensure they use the correct keys.

```sh
ssh -T git@github-account1
ssh -T git@github-account2
```

By following these steps, you can set up and use multiple GitHub accounts with the `init_repo.sh` script.

## License

This project is licensed under the MIT License.



### Explanation

- **Introduction**: Provides an overview of the script and its purpose.
- **Usage**: Explains how to use the script with examples.
- **Setup**: Details the prerequisites and steps to set up SSH keys and configure SSH for multiple accounts.
- **Additional Information**: Provides further instructions on setting up multiple GitHub accounts.
- **License**: Specifies the license for the project.

This `README.md` file should help users understand how to use the script and set up their environment for multiple GitHub accounts. Feel free to customize it further based on your specific requirements.
