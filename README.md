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

* Start the master node in the foreground
```bash
docker run --rm -ti -h salt --name salt --net salt-mgmt salt:latest salt-master --log-level=debug
```

* Alternatively, you can start master node in the background as well
```bash
docker run --rm -d -h salt --name salt --net salt-mgmt salt:latest salt-master --log-level=debug
```

* Start a minion node in the foreground
```bash
docker run --rm -ti -u root -h web1 --name web1 --net salt-mgmt salt:latest salt-minion --log-level=debug
```

* Alternatively, you can start a minion in the background as well
```bash
docker run --rm -d -u root -h web1 --name web1 --net salt-mgmt salt:latest salt-minion --log-level=debug
```


Salt activities
---------------
* Check a minion's key and its status on the master:
```bash
docker exec -t salt salt-key -f web1
```

* Query the fingerprint of a minion:
```bash
docker exec -t web1 salt-call --local key.finger
```
* Accept minion key
```bash
docker exec -ti salt salt-key -a web1
```

* Do sanity (ping test) check
```bash
docker exec -t salt salt '*' test.ping
```
