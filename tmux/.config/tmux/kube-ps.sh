#!/usr/bin/env bash

# Get KUBECONFIG from tmux pane variable or use default
get_kubeconfig() {
  local kubeconfig
  kubeconfig=$(tmux show-options -t "$pane" -p @kubeconfig 2>/dev/null | cut -d' ' -f2-)
  if [ -n "$kubeconfig" ]; then
    echo "$kubeconfig"
  else
    echo "${HOME}/.kube/config"
  fi
}

# Function to get current context
get_context() {
  local kubeconfig
  kubeconfig=$(get_kubeconfig)
  
  if [ -f "$kubeconfig" ]; then
    kubectl --kubeconfig="$kubeconfig" config current-context 2>/dev/null || echo "󱃾"
  else
    echo "󱃾"
  fi
}

# Function to get current namespace
get_namespace() {
  local kubeconfig context
  kubeconfig=$(get_kubeconfig)
  context=$(get_context)
  
  if [ "$context" != "󱃾" ] && [ -f "$kubeconfig" ]; then
    local namespace
    namespace=$(kubectl --kubeconfig="$kubeconfig" config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}" 2>/dev/null)
    if [ -n "$namespace" ]; then
      echo "$namespace"
    else
      echo "default"
    fi
  else
    echo "󱃾"
  fi
}

# Display context and namespace
context=$(get_context)
namespace=$(get_namespace)

if [ "$context" != "󱃾" ]; then
  echo " (${context}|${namespace}) "
else
  echo ""
fi
