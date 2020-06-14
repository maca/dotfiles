#!/bin/bash

aur -si ghcup-git
ghcup install-cabal
ghcup install latest
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
ghcup set 8.6.5
cabal update
cabal install tidal

echo 'add `PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"`'
