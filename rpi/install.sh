#!/bin/bash

# Install Shairport Sync and NQPTP for AirPlay 2 Support

# Function to remove existing NQPTP and Shairport Sync installations
remove_existing_installations() {
    echo "Removing existing installations of NQPTP and Shairport Sync..."

    # Remove old installation directories if they exist
    echo "Removing old installation directories..."
    sudo rm -rf nqptp
    sudo rm -rf shairport-sync

    # Remove old Shairport Sync binary if it exists
    if which shairport-sync > /dev/null; then
        echo "Removing old Shairport Sync binary..."
        sudo rm -f $(which shairport-sync)
    fi

    # Stop and disable any running Shairport Sync service
    echo "Stopping and disabling old Shairport Sync service..."
    sudo systemctl stop shairport-sync || true
    sudo systemctl disable shairport-sync || true

    # Remove Shairport Sync service files by searching dynamically
    echo "Searching for and removing old Shairport Sync service files..."
    sudo find / -name "shairport-sync.service" -exec rm -f {} \;

    # Remove old NQPTP binary if it exists
    if which nqptp > /dev/null; then
        echo "Removing old NQPTP binary..."
        sudo rm -f $(which nqptp)
    fi

    # Stop and disable any running NQPTP service
    echo "Stopping and disabling old NQPTP service..."
    sudo systemctl stop nqptp || true
    sudo systemctl disable nqptp || true

    # Remove NQPTP service files by searching dynamically
    echo "Searching for and removing old NQPTP service files..."
    sudo find / -name "nqptp.service" -exec rm -f {} \;

    echo "Cleanup complete."
}

# Call the function to remove existing installations
remove_existing_installations

# Update and install required packages
echo "Updating system and installing required packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install --no-install-recommends build-essential git autoconf automake libtool \
    libpopt-dev libconfig-dev libasound2-dev avahi-daemon libavahi-client-dev libssl-dev \
    libsoxr-dev libplist-dev libsodium-dev libavutil-dev libavcodec-dev libavformat-dev uuid-dev libgcrypt-dev xxd -y

# Clone, build, and install NQPTP (Required for AirPlay 2)
echo "Cloning and building NQPTP..."
git clone https://github.com/mikebrady/nqptp.git
cd nqptp
autoreconf -fi
./configure  --with-systemd-startup
make
sudo make install
cd ..  # Return to the parent directory

# Clone, build, and install Shairport Sync
echo "Cloning and building Shairport Sync..."
git clone https://github.com/mikebrady/shairport-sync.git
cd shairport-sync
autoreconf -fi
./configure --sysconfdir=/etc --with-alsa --with-soxr --with-avahi --with-ssl=openssl --with-systemd --with-airplay-2 --with-dbus-interface
make
sudo make install
cd ..  # Return to the parent directory

# Enable and start NQPTP service
echo "Enabling and starting NQPTP service..."
sudo systemctl enable nqptp
sudo systemctl start nqptp

# Enable and start Shairport Sync service
echo "Enabling and starting Shairport Sync service..."
sudo systemctl enable shairport-sync
sudo systemctl start shairport-sync

# Disable WiFi power management (optional)
echo "Disabling WiFi power management..."
sudo iwconfig wlan0 power off