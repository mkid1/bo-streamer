#### Install/Reinstall spotifyd and Rust

#!/bin/bash

#### Install spotifyd

### 1. Function to Install/Reinstall Rust

install_rust() {
    echo "Installing Rust..."

    # Remove existing Rust and Cargo installation from apt
    sudo apt remove rustc -y
    sudo apt remove cargo -y

    # Remove the entire .cargo and .rustup directories (clean up all previous Rust installations)
    rm -rf ~/.cargo ~/.rustup

    # Autoremove to clean up any unnecessary dependencies
    sudo apt autoremove -y

    # Install rustup (this installs the latest version of Rust and Cargo)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # Reload the shell environment to update the PATH for Cargo and Rust
    source ~/.profile

    echo "Rust installation complete."
}

### 2. Function to remove existing spotifyd installation

remove_spotifyd() {
    echo "Removing existing spotifyd installation..."

    # Remove spotifyd binary if installed via cargo
    if [ -f /home/mdt/.cargo/bin/spotifyd ]; then
        echo "Removing spotifyd binary..."
        cargo uninstall spotifyd
    fi

    # Stop and disable any running spotifyd service
    echo "Stopping and disabling spotifyd service..."
    sudo systemctl stop spotifyd || true
    sudo systemctl disable spotifyd || true

    # Remove spotifyd service files dynamically
    echo "Searching for and removing spotifyd service files..."
    sudo find / -name "spotifyd.service" -exec rm -f {} \;

    echo "spotifyd cleanup complete."
}

### 3. Prompt user for Rust installation or reinstallation

echo "Do you want to install or reinstall Rust? (yes/no)"
read -r rust_install_choice

if [[ "$rust_install_choice" == "yes" ]]; then
    install_rust
else
    echo "Skipping Rust installation."
fi

### 4. Main installation steps for spotifyd

# Call the function to remove existing spotifyd
remove_spotifyd

# Update system packages
echo "Updating system packages..."
sudo apt update

# Install necessary dependencies for spotifyd
echo "Installing necessary dependencies for spotifyd..."
sudo apt install -y libasound2-dev libssl-dev libpulse-dev

# Install spotifyd using cargo
echo "Installing spotifyd using cargo..."
cargo install spotifyd

# Create systemd service file for spotifyd
echo "Creating systemd service file for spotifyd..."
sudo bash -c 'cat > /etc/systemd/system/spotifyd.service <<EOF
[Unit]
Description=Spotify Daemon
After=network-online.target

[Service]
ExecStart=/home/mdt/.cargo/bin/spotifyd --no-daemon
Restart=always
User=mdt

[Install]
WantedBy=multi-user.target
EOF'

# Reload systemd to apply the new service
echo "Reloading systemd to apply new service..."
sudo systemctl daemon-reload

# Enable spotifyd to start at boot
echo "Enabling spotifyd to start at boot..."
sudo systemctl enable spotifyd

# Start spotifyd service
echo "Starting spotifyd service..."
sudo systemctl start spotifyd

echo "Spotifyd installation and setup complete."
