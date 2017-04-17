# tool branch

This are the list of all tools or sources I always want to have on my machines for easy access.


## Usage:

### Debian Quickstart

Pull in required Debian packages (via `sudo`) and compile all the submodules:
```bash
make debian all
```

Perhaps have a look at `Makefile` in the `debian` target to see prerequisites.
May be incomplete, though.


### MAC/OS-X

Sorry, I do not put much time in this.  `make mac` is missing for now, so you need this:

```bash
git submodule update --init macshim
cd macshim
make install
```

For now, this allows `gitstart` to function on my Mac, mostly.

### compile/install a single thing

It is designed for Debian.  I have a Mac now, too, but no clue yet how and when everything will compile there, too.

```bash
cd DIRECTORY
git submodule update --init
make
sudo make install
```

If something goes wrong utterly and you need some more bootstrapping:

```bash
cd DIRECTORY
git submodule update --init
cd tino
git co master
git pull
cd ..
make -f Makefile.tino
make
sudo make install
```

Be aware that this I need GNU tools like `gawk` and other tools like `md5sum`.


## TODO

The basic things should work as expected (on Debian).  However there still is a lot to do:

- Some tools still install into `$HOME/bin/` instead of `/usr/local/bin/`
- Change all references to my old distribution site http://www.scylla-charybdis.com/ to GitHub
- Move the DOMAIN http://www.scylla-charybdis.com/ to GitHub-Pages.
- Remove remenants of CVS in all code and supporting scripts etc.
- Change to a new GIT based distribution bundeling process by adding signed GIT TAGs
- Support Mac

I do not expect this not to complete before 2020, it may even take until 2030 or later, because I put very few effort into this, as it is mainly cosmetic.


## Contact

If this does not work, please try fix it yourself.  Perhaps an older version of TinoLib is needed or whatever.  Sorry that I have not much time to help yet, as I am very busy with other more important things (more important for me, not more important for you).  Thank you for your understanding.

If you really find something important, open an issue on GitHub or, even better, fix it and send me a pull request.  (However I can only incorporate your change if you accept your changes to become CLLed, see tinolib/COPYRIGHT.CLL.)

There also is a pager at https://hydra.geht.net/pager.php (machine currently down, sorry!)

My pager is the fastest and safest way to reach me (if it is available) besides a direct call to my mobile (when it is reachable).

