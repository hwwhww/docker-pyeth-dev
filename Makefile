setup:
	docker build -t localethereum/pyethapp-dev .
setup27:
	docker build -f Dockerfile-py27 -t localethereum/pyethapp-dev27 .

init-config:
	sh start.sh
init-source:
	test -d ./pydevp2p || git clone https://github.com/ethereum/pydevp2p.git --branch develop pydevp2p
	test -d ./pyethapp || git clone https://github.com/ethereum/pyethapp.git --branch develop pyethapp
	test -d ./pyethereum || git clone https://github.com/ethereum/pyethereum.git --branch develop pyethereum
	test -d ./sharding || git clone https://github.com/ethereum/sharding.git --branch develop sharding
	cd pyethereum && git submodule init && git submodule update --recursive

rebuild-boot-all:
	docker exec bootstrap bash -c "cd /pyeth/pydevp2p && python setup.py install"
	docker exec bootstrap bash -c "cd /pyeth/pyethereum && python setup.py install"
	docker exec bootstrap bash -c "cd /pyeth/sharding && pip install -r requirements.txt"
	docker exec bootstrap bash -c "cd /pyeth/pyethapp && pip install -e ."
rebuild-miner-all:
	docker exec miner bash -c "cd /pyeth/pydevp2p && python setup.py install"
	docker exec miner bash -c "cd /pyeth/pyethereum && python setup.py install"
	docker exec miner bash -c "cd /pyeth/sharding && pip install -r requirements.txt"
	docker exec miner bash -c "cd /pyeth/pyethapp && python setup.py install"
rebuild-miner27-all:
	docker exec miner bash -c "cd /pyeth/pydevp2p && python setup.py install"
	docker exec miner bash -c "cd /pyeth/pyethereum && python setup.py install"
	docker exec miner bash -c "cd /pyeth/sharding && pip install -r requirements.txt"
	docker exec miner bash -c "cd /pyeth/pyethapp && python setup.py install"

run-boot:
	docker exec bootstrap bash -c "pyethapp --password /root/.config/pyethapp/password.txt -l :info,eth:debug,pow:debug  --log-file /root/log/log.txt run &"
run-miner:
	docker exec miner bash -c "pyethapp -m 50 --password /root/.config/pyethapp/password.txt -l :info,eth:debug,pow:debug --log-file  /root/log/log.txt run &"

clear-boot:
	docker exec bootstrap bash -c "rm -r /root/.config/pyethapp/leveldb/"
clear-miner:
	docker exec miner bash -c "rm -r /root/.config/pyethapp/leveldb/"
