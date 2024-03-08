#!/usr/bin/env zsh
set -euo pipefail

declare -A context_of_target
context_of_target=(
  ["holo-aurutils--build"]="holo-aurutils" \
  ["holo-aurutils--repo"]="holo-aurutils" \
  ["holo-base-devel--aurbuild"]="holo-base-devel" \
  ["holo-base-devel--aurutils"]="holo-aurutils" \
  ["holo-binder_linux-dkms"]="holo-waydroid" \
  ["holo-binder_linux-dkms--build"]="holo-waydroid" \
  ["holo-binder_linux-dkms--repo"]="holo-waydroid" \
  ["holo-cage"]="holo-waydroid" \
  ["holo-waydroid--build"]="holo-waydroid" \
  ["holo-waydroid--bundle"]="holo-waydroid" \
  ["holo-waydroid--bundle--build"]="holo-waydroid" \
  ["holo-waydroid--bundle--repo"]="holo-waydroid" \
  ["holo-waydroid--repo"]="holo-waydroid" \
)

set_context_for_target() {
  while [[ -n ${context_of_target[$1]+x} ]]; do
    1=${context_of_target[$1]}
  done
  context=$1
}

case ${1+x} in
  '')
    for target in \
      "holo-base-devel" \
      "holo-base-devel--aurbuild" \
      "holo-base-devel--aurutils" \
      "holo-waydroid--bundle--repo"
    do
      set_context_for_target "$target"
      podman image build --jobs 3 -t "$target" "$context"
    done
    ;;
  *)
    target=$1; shift
    set_context_for_target "$target"
    podman image build -t "$target" "$context"
    ;;
esac
