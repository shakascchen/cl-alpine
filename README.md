# cl-base

もくもく会の環境構築用のDockerfileです。

[eshamsterさんのdocker-cl-base](https://github.com/eshamster/docker-cl-base)に少し変更して作成しました。

Roswell, Clack, Caveman2がインストールされています。

Docker Hubのページは[こちら](https://hub.docker.com/r/tcool/cl-base)です。

### インストール

```bash
$ docker pull tcool/cl-base
```

### 使い方
```bash
$ docker run -it tcool/cl-base
/ # ros run
```

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

### イメージの構成

- Alpine Linux (with glibc)
- Roswell
    - sbcl-bin
### 作者

eshamster (hamgoostar@gmail.com)

### 著作権

Copyright (c) 2016 eshamster (hamgoostar@gmail.com)

### ライセンス

Distributed under the MIT License
