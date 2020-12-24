sudo apt update
sudo apt install -y git zip unzip curl tmux jq

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

# vscode
sudo snap install --classic code

# Teams
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" | sudo tee /etc/apt/sources.list.d/teams.list
sudo apt update
sudo apt install -y teams

# sshuttle
apt-get install sshuttle
