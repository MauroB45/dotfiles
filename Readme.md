# Personal config

Here in this branch I keep and maintain my dotfiles for windows. This is my personal repository for my own personal setup!. It includes some tools, aliases and custom functions for productivity boost.

Please feel free to use it. [recomendations](#recomendations)

# Requirements
* **cmder** I use this one as my prefered terminal. However you can use conemu
* git for windows

after `installing git for windows` and `cmder` you can set up a new startup task in cmder settings. Go to `Settings > Startup > Tasks > +`
* task parameter = `/icon "c:\Program Files\Git\mingw64\share\git\git-for-windows.ico"` or your git installation
* command = "c:\Program Files\Git\bin\sh.exe" --login -i

also you can select the startup dir to be your home directory.

# Installation

In order to bootstrap and create the symlink for the configuration files:

```sh
# run in terminal
sh bootstrap.exclude.sh
```


# Recomendations

If you are going to use this setup please make sure to backup all your dotfile files first. Comments have been added so you can customize it.
