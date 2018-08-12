# cl-base

もくもく会の環境構築用のDockerfileです。

[eshamsterさんのdocker-cl-base](https://github.com/eshamster/docker-cl-base)を元に作成しました。

Common LispでWebアプリが開発できるように、Roswell, Clack, Caveman2, lemがインストールされています。

### インストール

```bash
$ docker pull tcool/cl-base
```

### 使い方

#### bashの起動

```bash
$ docker run -it tcool/cl-base
```

#### lemの起動

```
$ lem-ncurses
```

#### lemの基本操作

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

#### cavemanのロード、プロジェクトの雛形作成

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

### 作者

eshamster, t-cool

### 著作権

Copyright (c) 2016 eshamster, 2018 t-cool

### ライセンス

MIT
