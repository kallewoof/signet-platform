# Signetとc-lightningハンズオン
2020/8/18ビットコインとか勉強会

## Dockerをインストール

https://www.docker.com/


MacにDockerをインストール

https://hub.docker.com/editions/community/docker-ce-desktop-mac


UbuntuにDockerとDocker-composeをインストール

https://qiita.com/youtangai/items/ff67ceff5497a0e0b1af


Windows10の方はUbuntuを入れた上で、上記「UbuntuにDockerとDocker-composeをインストール」

https://www.microsoft.com/ja-jp/p/ubuntu/9nblggh4msv6?activetab=pivot:overviewtab

## Signet対応のbitcoindをインストールするDockerをビルド

```
git clone https://github.com/shu-kob/signet-platform
cd signet-platform
cd fullnode
./build.sh
```

## ビルドが終わったら起動

```
./run.sh
```

別ターミナルを開き、Dockerの中を操作するためコンテナのIDを取得

```
docker ps
```

```
ID=XXX
```

起動中のコンテナが一つだけの場合は以下で取得できる
```
ID=$(docker ps -q)
```

```
alias bcli="docker exec $ID bitcoin-cli"
```

bitcoindの状態を確認

```
bcli getblockchaininfo
```
ブロックチェーンエクスプローラとブロック高が一致すれば同期完了

https://explorer.bc-2.jp/

Dockerの中に入る場合は、別のターミナルを開き下記のコマンド

```
ID=$(docker ps -q)
docker exec -i -t $ID bash
bitcoin-cli getblockchaininfo
```
