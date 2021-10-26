# minimal-hive
Run a local hive "cluster" for learning/testing. Uses hive-3.1.2 and hadoop-3.3.0 for now.

# Installation
```
git clone git@github.com:isacarnekvist/minimal-hive.git
cd minimal-hive
docker build . -t minimal-hive
```

# Start the console
```
docker run --rm -it minimal-hive
```
