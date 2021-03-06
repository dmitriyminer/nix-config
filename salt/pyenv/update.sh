#!/bin/bash

export PATH="/home/{{ salt['user.current']() }}/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Identify the latest Python version.
latest_version=$(pyenv install --list | \
                       grep " 3." | \
                       grep -v [a-zA-Z] | \
                       tail -1 | \
                       sed "s/.* 3/3/")

# Install the latest Python version.
pyenv install -s $latest_version

# Set the latest Python version as the global default.
pyenv global $latest_version

# Upgrade pyenv-virtualenvwrapper.
pip install --upgrade virtualenvwrapper 1> /dev/null

# Upgrade pip.
pip install --upgrade pip 1> /dev/null
