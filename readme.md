## pyethapp development environment containers

This is a simple containized private network for `pyethapp` development with Docker Compose. It helps for:

1. Python2 / Python3 compatibility migration and testing
2. Understanding how to configure and develop pyethapp
3. Developing Casper and sharding on pyethapp

If you want to build pyethapp private network, please see [konradkonrad/docker-pyeth-cluster: pyethapp private cluster with docker-compose](https://github.com/konradkonrad/docker-pyeth-cluster).

## Docker Images
1. `Dockerfile` - Python3.6-based image
2. `Dockerfile-py27` - Python2.7-based image

## Default Containers

There are two sample default nodes: `bootstrap` node and `miner` node.

1. `miner` node would try to connect `bootstrap`.
2. `miner` mines
3. `bootstrap` exposes json-rpc host `0.0.0.0`


`miner-py27` node has the same configuration as `miner` node except `[node][privkey_hex]`. This node is used for testing Python2 during migration.


| Container Name | Image                        | Internal IP  | Ports Mapping                            |
|----------------|------------------------------|--------------|------------------------------------------|
| bootstrap      | localethereum/pyethapp-dev   | 172.18.250.2 | 40002:30303, 40002:30303/udp, 41002:8545 |
| miner          | localethereum/pyethapp-dev   | 172.18.250.3 | 40003:30303, 40003:30303/udp, 41003:8545 |
| miner-py27     | localethereum/pyethapp-dev27 | 172.18.250.4 | 40004:30303, 40004:30303/udp, 41004:8545 |


## How to use

There are some default commands in `Makefile` and some default configuration for testing `pyethapp`.


### 1. Download this repository
```sh
git clone https://github.com/hwwhww/docker-pyeth-dev.git
cd docker-pyeth-dev
```

### 2. Download source code for developing pyethapp
```sh
make init-source
```

> **[Note]**
> Regarding to `pyethapp` repository: the default branch is `ethereum/pyethapp` which doesn't support Python3 for now and the Python3 compatible PR is in review.
> For now, please switch to a workable branch manually: https://github.com/hwwhww/pyethapp/commits/dev_env

### 3. Build docker image
```sh
make setup
```

### 4. Initialize the configuration
```sh
make init-config
```
> Note that all containers share the same source code in `./shared_data/`.

### 5. Change `DOCKER_PYETH_DEV_REPO_ABSOLUTE_PATH` in docker-compose.yml manually
Change `DOCKER_PYETH_DEV_REPO_ABSOLUTE_PATH` to the absolute path of `docker-pyeth-dev` directory.

### 6. Build containers
```sh
docker-compose up -d
```

### 7. Rebuild source code
```sh
make rebuild-boot-all
make rebuild-miner-all
```

### 8. Run pyethapp daemon
* bootstrap node

    ```sh
    make run-boot
    ```
* miner node

    ```sh
    make run-miner
    ```

## Testing Python2
### 1. Build Python2 image
```sh
make setup27
```

### 2. Comment out the miner-py27 container in `docker-compose.yml` and then rebuild
```sh
docker-compose up -d
```

## Reference
* [konradkonrad/docker-pyeth-cluster: pyethapp private cluster with docker-compose](https://github.com/konradkonrad/docker-pyeth-cluster)
