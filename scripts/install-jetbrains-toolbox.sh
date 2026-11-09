#!/usr/bin/env zsh

set -euo pipefail

# switch this to eap if you require the early access version
RELEASE_TYPE=release
TOOLBOX_BIN_DIR=${HOME}/.local/share/JetBrains/Toolbox/bin

# if you have an existing install you should consider removing this directory first
install -d "${TOOLBOX_BIN_DIR}"

curl -sL \
    "$(curl -s "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=${RELEASE_TYPE}" \
        | jq -r '.TBA[0].downloads.linux.link')" \
    | tar xzvf - \
        --directory="${TOOLBOX_BIN_DIR}" \
        --strip-components=2

