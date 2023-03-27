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
asdf plugin add terraform
asdf plugin add terraform-ls

# Ruby
asdf install ruby 2.7.7
asdf install ruby 3.2.1

# Crystal
asdf install crystal 1.7.3

# NodeJS
asdf install nodejs 14.21.3
asdf install nodejs 16.19.1
asdf install nodejs 19.8.1

# Python
asdf install python 3.8.12
asdf install python 3.9.9
asdf install python 3.11.2

# PHP
asdf install php 8.2.3

# Rust
asdf install rust 1.68.1

# Go
asdf install golang 1.20.2

# Terraform
asdf install terraform 1.4.2

# Terraform Language Server
asdf install terraform-ls 0.30.3
