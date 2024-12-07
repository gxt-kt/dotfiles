#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if command -v "tmux-fingers" &>/dev/null; then
  FINGERS_BINARY="tmux-fingers"
elif [[ -f "$CURRENT_DIR/bin/tmux-fingers" ]]; then
  FINGERS_BINARY="$CURRENT_DIR/bin/tmux-fingers"
fi

if [[ -z "$FINGERS_BINARY" ]]; then
  tmux run-shell -b "bash $CURRENT_DIR/install-wizard.sh"
  exit 0
fi

CURRENT_FINGERS_VERSION="$($FINGERS_BINARY version)"

pushd $CURRENT_DIR &> /dev/null
CURRENT_GIT_VERSION=$(cat shard.yml | grep "^version" | cut -f2 -d':' | sed "s/ //g")
popd &> /dev/null

SKIP_WIZARD=$(tmux show-option -gqv @fingers-skip-wizard)
SKIP_WIZARD=${SKIP_WIZARD:-0}

if [ "$SKIP_WIZARD" = "0" ] && [ "$CURRENT_FINGERS_VERSION" != "$CURRENT_GIT_VERSION" ]; then
  tmux run-shell -b "FINGERS_UPDATE=1 bash $CURRENT_DIR/install-wizard.sh"

  if [[ "$?" != "0" ]]; then
    echo "Something went wrong while updating tmux-fingers. Please try again."
    exit 1
  fi
fi

tmux run "$FINGERS_BINARY load-config"
exit $?
