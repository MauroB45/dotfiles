# Personal config

Here in this branch I keep and maintain my dotfiles for windows. This is my personal repository for my own personal setup!. It includes some tools, aliases and custom functions for productivity boost.

Please feel free to use it. [recomendations](#recomendations)

# Requirements
* **cmder**. I use this one as my prefered terminal. However you can use conemu or the git bash if you want
* **git for windows**

After `installing git for windows` and `cmder` you can set up a new startup task in cmder settings. Go to `Settings > Startup > Tasks > +`. Set the task parameter to `/icon "c:\Program Files\Git\mingw64\share\git\git-for-windows.ico"` (or your git installation) and the command as `"c:\Program Files\Git\bin\sh.exe" --login -i`. Finally, you can also select the startup dir to be your home directory.

I would suggest setting this config as your default task.

# Installation

In order to bootstrap and create the symlink for the configuration files:

```sh
# run in terminal
sh bootstrap.exclude.sh

source ~/.bashrc
```

# How to use
You should now be able to use the aliases and functions provided. Please refer to the specific .functions and .aliases for more details.

# Recomendations

If you are going to use this setup please make sure to backup all your dotfile files first. Comments have been added so you can customize it.
