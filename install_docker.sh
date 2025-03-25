#!/bin/bash

# 実行方法
# curl -sSL https://script.dian.0am.jp/scripts/docker_install.sh | bash
# wget -qO- https://script.dian.0am.jp/scripts/docker_install.sh | bash

# whiptailがインストールされているか確認し、インストールされていない場合はインストール
if ! command -v whiptail &> /dev/null; then
    sudo apt update
    sudo apt install -y whiptail
fi

# TUIで選択肢を提供
choice=$(whiptail --title "Dockerインストールオプション" --menu "インストールするオプションを選択してください:" 15 60 4 \
"1" "Dockerのみ" \
"2" "DockerとDocker Compose" \
"3" "Docker、Docker Compose、Portainer" \

# Dockerのインストール
sudo apt update
sudo apt install -y \
ca-certificates \
curl \
gnupg \
lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

if [ "$choice" -ge 2 ]; then
    sudo apt install -y docker-compose-plugin
fi

if [ "$choice" -ge 3 ]; then
    # Portainerのインストール
    docker run -d -p 9443:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce
fi


echo "インストールが完了しました。"
