#!/bin/sh

# Plugins
asdf plugin add crystal
asdf plugin add nodejs
asdf plugin add php
asdf plugin add perl
asdf plugin add python
asdf plugin add ruby
asdf plugin add golang
asdf plugin add rust

# Ruby
asdf install ruby 2.7.4
asdf install ruby 3.0.3

# Crystal
asdf install crystal 1.2.2

# NodeJS
asdf install nodejs 10.24.1
asdf install nodejs 14.18.2
asdf install nodejs 16.13.1

# Python
asdf install python 3.8.12
asdf install python 3.9.9

# PHP
asdf install php 7.4.27
asdf install php 8.1.1

# Rust
asdf install rust 1.57.0

# Go
asdf install golang 1.17.5
