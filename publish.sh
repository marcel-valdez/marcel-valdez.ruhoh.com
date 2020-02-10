#!/usr/bin/env bash

target_dir=$1

function error {
  echo "FATAL: $1" >&2
  exit 1
}

[[ ! -z "${target_dir}" ]] || error "Please provide a target directory to publish to."
[[ -d "${target_dir}" ]] || error "Target directory ${target_dir} does not exist or is not a directory"

# clean path
target_dir="$(realpath ${target_dir})"

ruhoh compile || error "ruhoh compile failed. Cannot proceed"

# empty target
rm -fr "${target_dir}"/* || error "Failed to empty target."
# copy contents
cp -t "${target_dir}" -R ./compiled/* || error "Failed to copy contents."
# add CNAME
echo marcel.bowlitz.com > "${target_dir}/CNAME" || error "Failed to write CNAME."
