# cl-alpine

関西もくもく.lispの環境構築用Dockerfile/Docker Imageです。

Alpine Linuxをベースに、Roswell、Caveman2、lem、darkmatterがインストールしています。

| ソフトウェア | 概要 |
----|---- 
| Roswell | Common Lispの環境構築ができるユーティリティーです。 |
| Caveman2 | Common Lisp製のWebアプリケーションフレームワークです。 |
| lem | Common Lispの統合開発環境です。 |
| darkmatter | notebook形式のCommon Lisp実行環境です。 |


## 環境構築

事前に、いずれかのDockerをインストールしてください。

[Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

[Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

### Docker

#### イメージの取得

```bash
$ docker pull tcool/cl-web
```

#### コンテナの作成と起動

イメージを元にk-mokumokuという名前でコンテナを作成後、ポートフォワードでホスト側の8888番へのリクエストをコンテナの8888番につなぎます。`-it`オプションを使うことで、シェルを実行することができます。

```bash
docker run -it -p 8888:8888 --name k-mokumoku tcool/cl-base
```

#### コンテナを起動して、コンテナ内でシェルを実行する

起動中のコンテナを確認するには、`docker ps`を実行します。

```bash
docker ps

CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
```

上のように、コンテナが起動していないときには、`docker ps -a`でコンテナのIDを確認します。その後、`docker start コンテナID`でコンテナを起動します。

```bash
$ docker ps -a
CONTAINER ID     IMAGE            COMMAND          CREATED          STATUS           PORTS                  NAMES
1d5659fdb4f3     tcool/cl-base2   "/bin/bash"      31 minutes ago   Up 31 minutes    0.0.0.0:8888->8888/tcp k-mokumoku 

$ docker start 1d5659fdb4f3 
```

`docker exec -it コンテナ名 /bin/ash`でコンテナにログインします。

```bash
docker exec -it 1d5659fdb4f3 /bin/ash 
#\ ros run
* 
```

### darkmatter

darkmatterを読み込み、サーバを起動します。

```bash
/ # ros run
* (ql:quickload :darkmatter)
* (darkmatter:start :server :hunchentoot :port 8888)
```

サーバの起動後、[http://localhost:8888](http://localhost:8888)にアクセスすると、darkmatterを利用できます。

darkmatterに関する詳しい情報は、[darkmatterのレポジトリ](https://github.com/tamamu/darkmatter)をご参照ください。

### lem

lemを起動するには、`lem`と打ちこみます。

```
$ lem
```

基本操作は、以下の通りです。

| コマンド | 機能 |
|:---|:---|
| M-x lisp-mode | Lisp編集モードに変更 |
| M-x start-lisp-repl | 対話環境の開始 |
| C-x C-f | 新規ファイルの作成、diredの起動 |
| C-x o または M-o | バッファの移動 |
| C-x k | バッファの削除 |

`C-x`は、Controlを押しながらxを打ちます。`M-x`は、Altを押しながらxを打ちます。

`C-x C-e`は、`C-x`に続けて`C-e`を打ちます。`C-x o`は、`C-x`のあと、キーボードから指を離して、oを打ちます。

テキスト編集(選択/カット/コピー/ペースト)

|:---|:---|
| C-@ | 選択開始 |
| C-w | カット |
| M-w | コピー |
| C-y | ペースト |

※ vi-modeもありますので、好みに合わせて選択してください。

### Caveman

Common Lisp製のWebフレームワーク「Caveman2」で、プロジェクトの雛形を生成するには、次のようにします。
ここでは、myappという名前のプロジェクトを生成するとして進めます。

```common-lisp
* (ql:quickload :caveman2)
* (caveman2:make-project #P"/path/to/myapp/"
                         :author "<Your full name>")
;-> writing /path/to/myapp/.gitignore
;   writing /path/to/myapp/README.markdown
;   writing /path/to/myapp/app.lisp
;   writing /path/to/myapp/db/schema.sql
;   writing /path/to/myapp/shlyfile.lisp
;   writing /path/to/myapp/myapp-test.asd
;   writing /path/to/myapp/myapp.asd
;   writing /path/to/myapp/src/config.lisp
;   writing /path/to/myapp/src/db.lisp
;   writing /path/to/myapp/src/main.lisp
;   writing /path/to/myapp/src/view.lisp
;   writing /path/to/myapp/src/web.lisp
;   writing /path/to/myapp/static/css/main.css
;   writing /path/to/myapp/t/myapp.lisp
;   writing /path/to/myapp/templates/_errors/404.html
;   writing /path/to/myapp/templates/index.tmpl
;   writing /path/to/myapp/templates/layout/default.tmpl
```

サーバを起動するには、`(プロジェクト名:start :port ポート番号)`とします。例えば、myappというプロジェクトで8888番ポートでサーバを起動するには、つぎのようにします。

```
(myapp:start :port 8888)
```

ブラウザで[http://localhost:8888](http://localhost:8888)にアクセスをすると、"Hello, Caveman2!"と表示されます。

Amazon lightsail等で実行するには、`localhost`を固定IPアドレスに置き換えてください。

### デプロイ

AWSのLightsailにデプロイします。AWSにアカウントを作成後、次の初期化スクリプトを用いて、Ubuntuのインスタンスを作成、dockerとイメージをインストールしてください。

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install -y docker-engine
sudo service docker start

sudo docker pull tcool/cl-base
```

完了後、WebコンソールからSSH接続をして、次のコマンドを打てば、コンテナの中に入れます。

```bash
docker run -it -p 8888:8888 --name k-mokumoku tcool/cl-base
```

### 謝辞

eshamsterさんの[cl-base](https://github.com/eshamster/docker-cl-base)を元に作成しました。

### ライセンス

MIT
