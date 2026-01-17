#!/usr/bin/env bash

get_script_dir() {
  local script_path
  if [ ${#BASH_SOURCE[@]} -gt 1 ] && [[ ! "${BASH_SOURCE[1]}" =~ /utils/ ]]; then
    script_path="${BASH_SOURCE[1]}"
  else
    script_path="${BASH_SOURCE[-1]:-$0}"
  fi
  cd -- "$( dirname -- "$script_path" )" &> /dev/null && pwd
}
