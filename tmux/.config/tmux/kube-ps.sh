#!/bin/bash

# eval $(gardenctl kubectl-env bash)

# Function to get current context
get_context() {
  if [ -n "$KUBECONFIG" ]; then
    kubectl --kubeconfig="$KUBECONFIG" config current-context 2>/dev/null || echo "󱃾 "
  else
    KUBECONFIG=${HOME}/.kube/config
    kubectl config current-context 2>/dev/null || echo "󱃾 "
  fi
}

# Function to get current namespace
get_namespace() {
  local context
  context=$(get_context)
  if [ "$context" != "󱃾 " ]; then
    if [ -n "$KUBECONFIG" ]; then
      kubectl --kubeconfig="$KUBECONFIG" config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}" 2>/dev/null || echo "󱃾 "
    else
      KUBECONFIG=${HOME}/.kube/config
      kubectl config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}" 2>/dev/null || echo "󱃾 "
    fi
  else
    echo "󱃾 "
  fi
}

# Output based on argument
case "$1" in
  "context") get_context ;;
  "namespace") get_namespace ;;
  *) echo "Usage: $0 {context|namespace}" ;;
esac
