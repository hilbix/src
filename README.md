One repository to bind them all.

There are so many repositories I want to keep on each of my machines, so it was more easy to create a single one which combines everyting as sub-repositories.

`git submodule update --init` is your friend.


Usage
-----

```bash
git clone https://github.com/hilbix/src.git
git co tool
git submodule update --init
```

To pull in another branch/set of submodules:
```bash
git co more
git submodule update --init
```

The recipe to build a submodule, most times will be:
```bash
cd SUB
git co master
git pull
git submodule update --init
make
sudo make install
```

- Do not use `git clean` on this parent repo after switching branches.


Branches
--------

Following independent branches exist in this repo:

- master: empty, except for this README.  For future use.
- tool: most tools from http://www.scylla-charybdis.com/
- more: more tools from http://www.scylla-charybdis.com/ with known good alternatives on current Debian
- i2p: I2P stuff (incomplete)
- tino-X: some various experiments

and so on.
