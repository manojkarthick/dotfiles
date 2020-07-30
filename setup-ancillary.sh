#/bin/bash

# Install Antibody Plugin manager for Zsh (https://getantibody.github.io)
curl -sfL git.io/antibody | sh -s - -b ~/bin

# Install SDKMAN sdk manager for JVM (https://sdkman.io/install)
curl -s "https://get.sdkman.io" | bash


# Install kubernetes related tools
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl"
chmod u+x ./kubectl
mv ./kubectl ~/bin/kubectl

# Install Google cloud SDK and CLI
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-303.0.0-darwin-x86_64.tar.gz
tar xvf google-cloud-sdk-303.0.0-darwin-x86_64.tar.gz
mv google-cloud-sdk ~/bin/
