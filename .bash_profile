source ~/.exports

# Load my aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# Load my functions
if [ -f ~/.functions ]; then
  . ~/.functions
fi
