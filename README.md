# Full node

To get a full node running, do

```Bash
$ cd fullnode
$ ./build.sh # optional - takes time and CPU, but means you build it yourself
$ ./run.sh
```

# Faucet

You can make a personal faucet, which is useful in the classroom when everybody is on the same IP and can't use the default faucet.

```Bash
$ cd faucet
$ ./build.sh # optional - same as above, though this is pretty fast so why not?
$ ./run.sh
```

Faucet should appear if you go to http://localhost on your machine. Other people should see the faucet if they go to http://YOURIPNUMBER as well. If they don't, you may need to (temporarily) turn off your firewall. Remember to turn it on again afterwards.

The faucet will need some balance, so fetch from the global faucet into yours.

```Bash
# from a different terminal, without terminating the run.sh call above
$ docker ps
# CONTAINER ID        IMAGE                          COMMAND                  CREATED              STATUS              PORTS                                                                                                                    NAMES
# 97e1b08651b6        nginx:latest                   "nginx -g 'daemon of…"   43 seconds ago       Up 42 seconds       0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp                                                                                 faucet_nginx_1
# 255afd0c6172        kallewoof/signet:0.18          "/entrypoint.sh bitc…"   About a minute ago   Up About a minute   8332-8333/tcp, 18332-18333/tcp, 18443-18444/tcp, 28332-28333/tcp, 38332-38333/tcp, 39388/tcp, 0.0.0.0:43782->43782/tcp   faucet_signet_1
# ^^^^^^^^^^^^        ^^^^^^^^^^^^^^^^^^^^^ (this is the one we want)
# f087ee46666b        mongo                          "docker-entrypoint.s…"   About a minute ago   Up About a minute   27017/tcp                                                                                                                faucet_mongo_1
# cbfacae62149        kallewoof/signet-faucet:0.18   "./index.js"             About a minute ago   Up About a minute   8123/tcp                                                                                                                 faucet_faucet_1
$ docker exec 255afd0c6172 bitcoin-cli getbalance
# 0.00000000
$ docker exec 255afd0c6172 getcoins.sh
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100   156    0   106  100    50     34     16  0:00:03  0:00:03 --:--:--    34
# Payment of 10.00000000 BTC sent with txid d7d0b234b6cec0029421b71bd4740448a028b3c436a58e1e175d2d2d1a0287a8
$ docker exec 255afd0c6172 bitcoin-cli getunconfirmedbalance
# 10.00000000
```

Faucet will become functional as soon as the next block is mined. It will by default send between 10~100 mBTC.

# Block explorer

Coming soon.

# Lightning node

WIP (help welcome)

# Mobile wallet

WIP (help welcome)
