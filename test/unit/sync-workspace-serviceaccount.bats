#!/usr/bin/env bats

load _helpers

@test "syncWorkspace/ServiceAccount: disabled by default" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/sync-workspace-serviceaccount.yaml  \
      . | tee /dev/stderr |
      yq 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "false" ]
}

@test "syncWorkspace/ServiceAccount: disabled with global.enabled=false" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/sync-workspace-serviceaccount.yaml  \
      --set 'global.enabled=false' \
      . | tee /dev/stderr |
      yq 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "false" ]
}

@test "syncWorkspace/ServiceAccount: disabled with sync disabled" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/sync-workspace-serviceaccount.yaml  \
      --set 'syncWorkspace.enabled=false' \
      . | tee /dev/stderr |
      yq 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "false" ]
}

@test "syncWorkspace/ServiceAccount: enabled with sync enabled" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/sync-workspace-serviceaccount.yaml  \
      --set 'syncWorkspace.enabled=true' \
      . | tee /dev/stderr |
      yq 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "true" ]
}

@test "syncWorkspace/ServiceAccount: enabled with sync enabled and global.enabled=false" {
  cd `chart_dir`
  local actual=$(helm template \
      -x templates/sync-workspace-serviceaccount.yaml  \
      --set 'global.enabled=false' \
      --set 'syncWorkspace.enabled=true' \
      . | tee /dev/stderr |
      yq -s 'length > 0' | tee /dev/stderr)
  [ "${actual}" = "true" ]
}
