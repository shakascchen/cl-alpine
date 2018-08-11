# cl-base

roswellを含んだCommon Lisp開発環境をセットアップするためのDockerfileです。

[eshamsterさんのdocker-cl-base](https://github.com/eshamster/docker-cl-base)からのフォークです。

もくもく会用に少し変更して利用させてもらいます。

## インストール

```bash
$ docker pull tcool/cl-base
```

## 使い方
```bash
$ docker run -it tcool/cl-base
/ # ros run
* (format t "Hello, world.")
Hello, world.
NIL
* 
```

## イメージの構成

- Alpine Linux (with glibc)
- Roswell
    - sbcl-bin

---------

## 作者

eshamster (hamgoostar@gmail.com)

## 著作権

Copyright (c) 2016 eshamster (hamgoostar@gmail.com)

## ライセンス

Distributed under the MIT License
