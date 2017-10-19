#!/bin/bash

test -d ./data/bootstrap || mkdir -p ./data/bootstrap
test -d ./data/miner || mkdir -p ./data/miner
test -d ./data/miner-py27 || mkdir -p ./data/miner-py27

test -d ./data/bootstrap/log || mkdir -p ./data/miner/log
test -d ./data/miner/log || mkdir -p ./data/miner/log
test -d ./data/miner-py27/log || mkdir -p ./data/miner-py27/log

test -d ./data/bootstrap/config || mkdir -p ./data/bootstrap/config && cp ./docker/config_bootstrap.yaml ./data/bootstrap/config/config.yaml
test -d ./data/miner/config || mkdir -p ./data/miner/config && cp ./docker/config_miner.yaml ./data/miner/config/config.yaml
test -d ./data/miner-py27/config || mkdir -p ./data/miner-py27/config && cp ./docker/config_miner.yaml ./data/miner-py27/config/config.yaml

test -d ./data/bootstrap/config/keystore || cp -r ./docker/keystore ./data/bootstrap/config/keystore
test -d ./data/miner/config/keystore || cp -r ./docker/keystore ./data/miner/config/keystore
test -d ./data/miner-py27/config/keystore || cp -r ./docker/keystore ./data/miner-py27/config/keystore

cp ./docker/privkey_bootstrap.hex ./data/bootstrap/config/privkey.hex
cp ./docker/privkey_miner.hex ./data/miner/config/privkey.hex
cp ./docker/privkey_miner.hex ./data/miner-py27/config/privkey.hex

cp ./docker/password.txt ./data/bootstrap/config/
cp ./docker/password.txt ./data/miner/config/
cp ./docker/password.txt ./data/miner-py27/config/
