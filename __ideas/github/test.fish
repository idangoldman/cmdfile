#!/usr/bin/env fish

dependencies mkdir touch gh gawk yq jq
sources "$CMDFILE_PATH/__ideas/github/main.fish"

main pull
