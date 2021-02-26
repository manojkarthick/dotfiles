#!/bin/bash

# Install Antibody Plugin manager for Zsh (https://getantibody.github.io)
curl -sfL git.io/antibody | sh -s - -b ~/bin

# Install SDKMAN sdk manager for JVM (https://sdkman.io/install)
curl -s "https://get.sdkman.io" | bash


# Install kubernetes related tools
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl"
chmod u+x ./kubectl
mv ./kubectl ~/bin/kubectl

# To install kubernetes CLI plugins, first install krew
(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
  "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
  "$KREW" update
)
# Sourced from https://krew.sigs.k8s.io/docs/user-guide/setup/install/#bash
# Install plugins ctx and ns
kubectl krew install ns
kubectl krew install ctx


# Install Google cloud SDK and CLI
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-303.0.0-darwin-x86_64.tar.gz
tar xvf google-cloud-sdk-303.0.0-darwin-x86_64.tar.gz
mv google-cloud-sdk ~/bin/

# Install rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
