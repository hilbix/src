*Note: Switch to branch [`tool`](../../tree/tool) to see what's in here for you!*

# One Repo to bring them all

There are so many repositories I want to keep on each of my machines, so it was more easy to create a single one which combines everyting as sub-repositories.  So I only have to `clone` this one and then can easily pull the rest using `co`.


## Usage

```bash
git clone https://github.com/hilbix/src.git
git checkout tool
git submodule update --init
```

To pull in another branch/set of submodules:
```bash
git checkout more
git submodule update --init
```

The recipe to build a submodule `SUB`, most times will be:
```bash
cd SUB
git checkout master
git pull
git submodule update --init
make
sudo make install
```

- When switching branches, ignore the message, that some subdirectories cannot be removed, this is the normal intended behavior.  Use `git status` afterwards to see that it is really clean.
- Do not use `git clean` on this parent repo after switching branches, else you possibly destroy your unsaved edits on other branches!
- Please do not be puzzled.  If you are missing something or something isn't looking correctly, it is possibly on another branch.  For example, `README.md` is different on each branch or even may be missing on one.


## Branches

Following independent branches exist in this repo:

- master: empty, except for this README.  For future use.
- tool: most tools from http://www.scylla-charybdis.com/

Following branches may be added someday:
- more: more tools from http://www.scylla-charybdis.com/ with known good alternatives on current Debian
- i2p: I2P stuff (incomplete)
- tino-X: some various experiments

and so on.


## License

This is a Repo of Repos, so no license needed.

