# Docker Installer Script - README

## 概要
このスクリプトは、Ubuntu環境において、以下のソフトウェアをインストールするためのツールです：
- Docker
- Docker Compose
- Portainer (オプション)
- Dockhand (オプション)

TUI (Text User Interface) を使用して、インストールするコンポーネントを選択することができ���す。

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

Github Pages経由でCurlコマンドから実行することもできます。
```bash
curl -fsSL https://kawadian.github.io/EasyDockerInstall/install_docker.sh | bash
```

スクリプトを実行すると、whiptailを利用した選択メニューが表示されます。以下の選択肢の中から、インストールしたいオプションを選んでください：

---

## インストールオプション

### 1. Dockerのみ
Dockerエンジンをインストールします。

### 2. DockerとDocker Compose
Dockerエンジンと、docker-compose-pluginをインストールします。

### 3. Docker、Docker Compose、Portainer
Dockerエンジン、docker-compose-plugin、およびPortainer（Docker管理用のWebインターフェイス）をインストールします。
- アクセスURL: `https://サーバーIP:9443`

### 4. Docker、Docker Compose、Dockhand
Dockerエンジン、docker-compose-plugin、およびDockhand（セキュリティ重視のDocker管理ツール）をインストールします。
- アクセスURL: `http://サーバーIP:3000`

---

## 処理の流れ

### TUIでの選択
ユーザーが選択肢を選ぶための簡易UIを表示します。

### Dockerのインストール
- 必要な依存パッケージをインストールします。
- Dockerの公式GPGキーとリポジトリを追加します。
- Docker関連パッケージをインストールします。

### Docker Composeのインストール（選択時）
ユーザーの選択に応じて、docker-compose-pluginをインストールします。

### Portainerのインストール（選択時）
PortainerをDockerコンテナとして起動します。データは永続化されるように設定されます。

### Dockhandのインストール（選択時）
DockhandをDockerコンテナとして起動します。データは永続化されるように設定されます。

### 完了メッセージ
すべての処理が完了したら、インストール成功のメッセージを表示します。