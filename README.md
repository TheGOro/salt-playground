Salt playground
===============
The purpose of this repository is to provide an easy to use Docker based containerized environment to play with SaltStack. Basically, a practice lab for learning...

* Build image for the salt nodes
```bash
docker build -t salt:latest .
```
* Create a management network:
```bash
docker network create salt-mgmt
```

* Start the master node
```bash
docker run --rm -ti -h salt --name salt --net salt-mgmt salt:latest salt-master --log-level=debug
```
* Start a minion node
```bash
docker run --rm -ti -h minion01 --name minion01 --net salt-mgmt salt:latest salt-minion --log-level=debug
```

Salt activities
---------------
* Check a minion's key and its status on the master:
```bash
docker exec -t salt salt-key -f minion01
```

* Query the fingerprint of a minion:
```bash
docker exec -t minion01 salt-call --local key.finger
```
* Accept minion key
```bash
docker exec -t salt salt-key -a minion01
```

* Do sanity check
```bash
docker exec -t salt salt '*' test.ping
```
