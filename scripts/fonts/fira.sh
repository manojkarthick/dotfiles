#!/bin/bash

echo "Downloading Fira code fonts from master on github"

set -x

mkdir -pv FiraCode && cd FiraCode || return
wget https://github.com/tonsky/FiraCode/raw/master/distr/ttf/FiraCode-Bold.ttf
wget https://github.com/tonsky/FiraCode/raw/master/distr/ttf/FiraCode-Light.ttf
wget https://github.com/tonsky/FiraCode/raw/master/distr/ttf/FiraCode-Medium.ttf
wget https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-Regular.ttf
wget https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-Retina.ttf
wget https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-SemiBold.ttf
