#!/bin/bash

set -e

# 実行方法
# curl -sSL https://script.dian.0am.jp/scripts/docker_install.sh | bash
# wget -qO- https://script.dian.0am.jp/scripts/docker_install.sh | bash

# whiptail がインストールされていなければインストール
if ! command -v whiptail &> /dev/null; then
    sudo apt update
    sudo apt install -y whiptail
fi

# TUI でインストールオプションを選択
CHOICE=$(whiptail --title "Dockerインストールオプション" \
--menu "インストールするオプションを選択してください:" 15 60 3 \
    "1" "Dockerのみ" \
    "2" "DockerとDocker Compose" \
    "3" "Docker、Docker Compose、Portainer" \
3>&1 1>&2 2>&3)

# Cancel 押下時は終了
if [ $? -ne 0 ]; then
    echo "キャンセルされました。スクリプトを終了します。"
    exit 1
fi

# Docker 本体インストール
sudo apt update
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
   https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Docker グループに現在ユーザーを追加
sudo usermod -aG docker $USER

# Docker Compose のインストール（選択肢 >=2 の場合）
if [ "$CHOICE" -ge 2 ]; then
    sudo apt install -y docker-compose-plugin
fi

# Portainer のインストール（選択肢 =3 の場合）
if [ "$CHOICE" -eq 3 ]; then
    sudo docker volume create portainer_data
    sudo docker run -d \
      -p 9443:9443 \
      --name portainer \
      --restart=always \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v portainer_data:/data \
      portainer/portainer-ce:latest
fi

echo "インストールが完了しました。"
echo "Docker グループの変更を反映するには、再ログインするか以下コマンドを実行してください:"
echo "  newgrp docker"
