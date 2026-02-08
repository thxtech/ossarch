#!/usr/bin/env bash
set -euo pipefail

# Add Category field to all existing OSS README.md files
# Inserts "| Category | {value} |" after "| Primary Language |" line

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OSS_DIR="$SCRIPT_DIR/../oss"

get_category() {
  local project="$1"
  case "$project" in
    # Container Runtime
    containerd|moby|podman) echo "Container Runtime" ;;

    # Container Orchestration
    compose|kubernetes|helm|nomad) echo "Container Orchestration" ;;

    # Security
    falco|keycloak|trivy|vault|harbor) echo "Security" ;;

    # Networking
    caddy|cilium|consul|coredns|envoy|istio|linkerd2|traefik) echo "Networking" ;;

    # Monitoring
    cortex|grafana|loki|opentelemetry-collector|prometheus|thanos) echo "Monitoring" ;;

    # Database
    clickhouse|cockroachdb|dgraph|duckdb|etcd|influxdb|minio|qdrant|redis|rocksdb|rook|tidb|tikv|vitess|weaviate) echo "Database" ;;

    # GitOps
    argo-cd|flux2) echo "GitOps" ;;

    # IaC
    crossplane|opentofu|terraform) echo "IaC" ;;

    # Cloud Platform
    supabase) echo "Cloud Platform" ;;

    # Runtime
    bun|deno|dapr|tokio|wasmtime) echo "Runtime" ;;

    # Web Framework
    angular|fastapi|gin|leptos|nestjs|nextjs|quarkus|react|remix|solid|spring-boot|svelte) echo "Web Framework" ;;

    # Build Tool
    esbuild|swc|turborepo|vite) echo "Build Tool" ;;

    # Data Processing
    arrow|flink|kafka|nats-server|polars|pulsar|ray|spark) echo "Data Processing" ;;

    # Editor / Terminal
    alacritty|helix|neovim|nushell|wezterm|zed|zellij) echo "Editor / Terminal" ;;

    # Developer Tool
    backstage|buf|dagger|gitea|ruff|rust-analyzer) echo "Developer Tool" ;;

    # Desktop Application
    excalidraw|tauri) echo "Desktop Application" ;;

    # Blockchain
    go-ethereum) echo "Blockchain" ;;

    # Workflow Engine
    airflow|temporal) echo "Workflow Engine" ;;

    # Search Engine
    elasticsearch) echo "Search Engine" ;;

    # Game Engine
    bevy) echo "Game Engine" ;;

    # Document Processor
    typst) echo "Document Processor" ;;

    # Static Site Generator
    hugo) echo "Static Site Generator" ;;

    # CLI Tool
    fzf|starship) echo "CLI Tool" ;;

    *) echo "Uncategorized" ;;
  esac
}

count=0
skipped=0

for readme in "$OSS_DIR"/*/README.md; do
  dir="$(basename "$(dirname "$readme")")"

  # Skip template
  if [ "$dir" = "_template" ]; then
    continue
  fi

  # Skip if Category already exists
  if grep -q "^| Category |" "$readme"; then
    skipped=$((skipped + 1))
    continue
  fi

  category="$(get_category "$dir")"

  # Insert Category line after Primary Language line
  if grep -q "^| Primary Language |" "$readme"; then
    sed -i '' "/^| Primary Language |/a\\
| Category | ${category} |
" "$readme"
    count=$((count + 1))
    echo "Added: $dir -> $category"
  else
    echo "WARN: No Primary Language line found in $dir"
  fi
done

echo ""
echo "Done: $count files updated, $skipped already had Category"
