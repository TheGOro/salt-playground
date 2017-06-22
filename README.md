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
docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d -h salt --name salt --net salt-net salt:latest
```

* Alternatively, you can start a minion in the background as well
```bash
docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d -h web1 --name web1 --net salt-net -p 8000:8000 salt:latest
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
