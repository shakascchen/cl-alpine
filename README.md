# cl-base

もくもく会の環境構築用のDockerfile/Docker Imageです。

Common LispでWebアプリが開発できるように、Roswell, Clack, Caveman2, lemがインストールされています。

[eshamsterさんのdocker-cl-base](https://github.com/eshamster/docker-cl-base)を元に作成しました。

### 環境要件

事前に、いずれかのDockerをインストールしてください。

[Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

[Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

## 使い方

### Dockerイメージの取得

```bash
$ docker pull tcool/cl-base
```

#### コンテナの作成とログイン

イメージを元にk-mokumokuという名前でコンテナを作成後、ポートフォワードでホスト側の8888番へのリクエストをコンテナの8888番につなぎます。

```bash
docker run -it -p 8888:8888 --name k-mokumoku tcool/cl-base
```

#### ClackでHello, Clack!

```bash
/ # ros run
* (ql:quickload :clack)
To load "clack":
  Load 1 ASDF system:
    clack
; Loading "clack"
.
(:CLACK)
* (defvar *handler*
    (clack:clackup
      (lambda (env)
        (declare (ignore env))
        '(200 (:content-type "text/plain") ("Hello, Clack!")))))

Hunchentoot server is started.
Listening on localhost:4000.
*HANDLER*
* 
```

ブラウザで[http://localhost:8080](http://localhost:8080)にアクセスをすると、Hello, Clack!と表示されます。

#### lemの起動と操作

```
$ lem-ncurses
```

| コマンド | 機能 |
|:---|:---|
| M-x lisp-mode | Lisp編集モードに変更 |
| M-x start-lisp-repl | 対話環境の開始 |
| C-x C-f | 新規ファイルの作成、diredの起動 |
| C-c C-c | S式のコンパイル |
| C-x C-e | S式の評価 |
| C-x o | バッファの移動 |
| C-x k | バッファの削除 |

※ vi-modeもありますので、好みに合わせて選択してください。

#### Caveman：プロジェクトの雛形作成

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

#### デプロイ

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

### 作者

eshamster, t-cool

### 著作権

2016 eshamster, 2018 t-cool

### ライセンス

MIT
