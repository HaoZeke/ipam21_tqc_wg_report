## Author: Rohit Goswami, 5/05/2021
## Email: rog32@hi.is
## Date: 5/05/2021
!/usr/bin/env sh

# Originally from https://github.com/latex3/latex3
# Modified variant of https://tex.stackexchange.com/questions/398830/how-to-build-my-latex-automatically-with-pdflatex-using-travis-ci

# This script is used for testing using Travis
# It is intended to work on their VM set up: Ubuntu 12.04 LTS
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached version of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl --profile=$1

  cd ..
fi

# Just including texlua so the cache check above works
# Needed for any use of texlua even if not testing LuaTeX
tlmgr install luatex
tlmgr install scheme-small

# Other contrib packages: done as a block to avoid multiple calls to tlmgr
# texlive-latex-base is needed to run pdflatex
tlmgr install   \
  exam          \
  amsfonts      \
  stmaryrd      \
  biber         \
  beamer        \
  xetex         \
  pdflatex      \
  latexmk       \
  etoolbox      \
  minted        \
  texliveonfly  \
  baskervaldx   \
  Asana-Math    \
  cascadia-code \
  beamertheme-metropolis \
  amsmath

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install
