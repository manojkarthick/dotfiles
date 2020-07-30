#/bin/bash

# Install Antibody Plugin manager for Zsh (https://getantibody.github.io)
curl -sfL git.io/antibody | sh -s - -b ~/bin

# Install SDKMAN sdk manager for JVM (https://sdkman.io/install)
curl -s "https://get.sdkman.io" | bash


# Install kubernetes related tools
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl"
chmod u+x ./kubectl
mv ./kubectl ~/bin/kubectl
