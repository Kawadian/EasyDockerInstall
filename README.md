# Docker Installer Script - README

## 概要
このスクリプトは、Ubuntu環境において、以下のソフトウェアをインストールするためのツールです：
- Docker
- Docker Compose
- Portainer (オプション)

TUI (Text User Interface) を使用して、インストールするコンポーネントを選択することができます。

---

## 要件
- UbuntuベースのLinuxディストリビューションで動作することを想定しています。
- `sudo`権限を持つユーザーで実行する必要があります。
- インターネット接続が必要です。

---

## スクリプトの使用方法
### スクリプトの実行
以下のコマンドを実行してスクリプトを起動してください：
```bash
bash install_docker.sh
```
TUI（選択画面）の操作スクリプトを実行すると、whiptailを利用した選択メニューが表示されます。以下の選択肢の中から、インストールしたいオプションを選んでください：

Dockerのみ
Dockerエンジンをインストールします。


DockerとDocker Compose
Dockerエンジンと、docker-compose-pluginをインストールします。


Docker、Docker Compose、Portainer
Dockerエンジン、docker-compose-plugin、およびPortainer（Docker管理用のWebインターフェイス）をインストールします。

TUIでの選択

ユーザーが選択肢を選ぶための簡易UIを表示します。



Dockerのインストール

必要な依存パッケージをインストールします。
Dockerの公式GPGキーとリポジトリを追加します。
Docker関連パッケージをインストールします。



Docker Composeのインストール（選択時）

ユーザーの選択に応じて、docker-compose-pluginをインストールします。



Portainerのインストール（選択時）

PortainerをDockerコンテナとして起動します。データは永続化されるように設定されます。



完了メッセージ

すべての処理が完了したら、インストール成功のメッセージを表示します。