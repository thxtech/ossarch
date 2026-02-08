# OSS Architecture Reports

## Table of Contents

- [Blockchain](#blockchain)
- [Build Tool](#build-tool)
- [CLI Tool](#cli-tool)
- [Cloud Platform](#cloud-platform)
- [Container Orchestration](#container-orchestration)
- [Container Runtime](#container-runtime)
- [Data Processing](#data-processing)
- [Database](#database)
- [Desktop Application](#desktop-application)
- [Developer Tool](#developer-tool)
- [Document Processor](#document-processor)
- [Editor / Terminal](#editor--terminal)
- [Game Engine](#game-engine)
- [GitOps](#gitops)
- [IaC](#iac)
- [Monitoring](#monitoring)
- [Networking](#networking)
- [Runtime](#runtime)
- [Search Engine](#search-engine)
- [Security](#security)
- [Static Site Generator](#static-site-generator)
- [Web Framework](#web-framework)
- [Workflow Engine](#workflow-engine)

## Blockchain

| Project | Description | Language |
|---|---|---|
| [Go Ethereum (Geth)](oss/go-ethereum/README.md) | Official Go implementation of the Ethereum protocol - the execution layer client for the Ethereum blockchain | Go |

## Build Tool

| Project | Description | Language |
|---|---|---|
| [esbuild](oss/esbuild/README.md) | An extremely fast JavaScript and CSS bundler written in Go | Go |
| [SWC](oss/swc/README.md) | Speedy Web Compiler: A super-fast TypeScript/JavaScript compiler written in Rust | Rust |
| [Turborepo](oss/turborepo/README.md) | High-performance build system for JavaScript and TypeScript codebases, written in Rust | Rust |
| [Vite](oss/vite/README.md) | Next generation frontend tooling that provides instant server start and lightning fast Hot Module Replacement (HMR). | TypeScript |

## CLI Tool

| Project | Description | Language |
|---|---|---|
| [fzf](oss/fzf/README.md) | A general-purpose command-line fuzzy finder written in Go | Go |
| [Starship](oss/starship/README.md) | The minimal, blazing-fast, and infinitely customizable prompt for any shell | Rust |

## Cloud Platform

| Project | Description | Language |
|---|---|---|
| [Supabase](oss/supabase/README.md) | The open-source Postgres development platform -- building Firebase-like features using enterprise-grade open-source tools on top of PostgreSQL. | TypeScript |

## Container Orchestration

| Project | Description | Language |
|---|---|---|
| [Docker Compose](oss/compose/README.md) | Define and run multi-container applications with Docker | Go |
| [Helm](oss/helm/README.md) | The Kubernetes Package Manager | Go |
| [Kubernetes](oss/kubernetes/README.md) | Production-grade container scheduling and management system for automating deployment, scaling, and operations of application containers across clusters of hosts. | Go |
| [Nomad](oss/nomad/README.md) | A simple and flexible workload orchestrator to deploy and manage containers, non-containerized applications, and virtual machines across on-prem and clouds at scale | Go |

## Container Runtime

| Project | Description | Language |
|---|---|---|
| [containerd](oss/containerd/README.md) | An industry-standard container runtime with an emphasis on simplicity, robustness, and portability | Go |
| [Moby (Docker Engine)](oss/moby/README.md) | The Moby Project - a collaborative project for the container ecosystem to assemble container-based systems | Go |
| [Podman](oss/podman/README.md) | A daemonless tool for managing OCI containers, pods, and images with Docker-compatible CLI | Go |

## Data Processing

| Project | Description | Language |
|---|---|---|
| [Apache Arrow](oss/arrow/README.md) | Universal columnar format and multi-language toolbox for fast data interchange and in-memory analytics | C++ |
| [Apache Flink](oss/flink/README.md) | A distributed stream processing framework for stateful computations over unbounded and bounded data streams | Java |
| [Apache Kafka](oss/kafka/README.md) | A distributed event streaming platform for high-throughput, fault-tolerant data pipelines and real-time analytics | Java |
| [Apache Pulsar](oss/pulsar/README.md) | A distributed pub-sub messaging platform with multi-tenancy and geo-replication built-in | Java |
| [Apache Spark](oss/spark/README.md) | A unified analytics engine for large-scale data processing | Scala |
| [NATS Server](oss/nats-server/README.md) | High-performance server for NATS.io, the cloud and edge native messaging system. | Go |
| [Polars](oss/polars/README.md) | Extremely fast Query Engine for DataFrames, written in Rust | Rust |
| [Ray](oss/ray/README.md) | A unified framework for scaling AI and Python applications with distributed computing | Python |

## Database

| Project | Description | Language |
|---|---|---|
| [ClickHouse](oss/clickhouse/README.md) | A real-time analytics database management system with column-oriented storage architecture | C++ |
| [CockroachDB](oss/cockroachdb/README.md) | A cloud-native, distributed SQL database designed for high availability, effortless scale, and control over data placement. | Go |
| [Dgraph](oss/dgraph/README.md) | A horizontally scalable and distributed GraphQL database with a graph backend | Go |
| [DuckDB](oss/duckdb/README.md) | An in-process analytical SQL database management system for OLAP workloads | C++ |
| [etcd](oss/etcd/README.md) | Distributed reliable key-value store for the most critical data of a distributed system | Go |
| [InfluxDB](oss/influxdb/README.md) | Scalable datastore for metrics, events, and real-time analytics | Rust |
| [MinIO](oss/minio/README.md) | A high-performance, S3-compatible object storage solution for AI/ML, analytics, and data-intensive workloads | Go |
| [Qdrant](oss/qdrant/README.md) | High-performance, massive-scale Vector Database and Vector Search Engine for the next generation of AI | Rust |
| [Redis](oss/redis/README.md) | The preferred, fastest, and most feature-rich in-memory data structure server, cache, and real-time data engine for developers building data-driven applications. | C |
| [RocksDB](oss/rocksdb/README.md) | A library that provides an embeddable, persistent key-value store for fast storage | C++ |
| [Rook](oss/rook/README.md) | Storage Orchestration for Kubernetes | Go |
| [TiDB](oss/tidb/README.md) | An open-source, cloud-native, distributed SQL database designed for modern applications | Go |
| [TiKV](oss/tikv/README.md) | A distributed transactional key-value database powered by Rust and Raft, originally created to complement TiDB | Rust |
| [Vitess](oss/vitess/README.md) | A cloud-native horizontally-scalable distributed database system built around MySQL | Go |
| [Weaviate](oss/weaviate/README.md) | An open-source, cloud-native vector database that stores both objects and vectors, enabling semantic search and RAG applications at scale | Go |

## Desktop Application

| Project | Description | Language |
|---|---|---|
| [Excalidraw](oss/excalidraw/README.md) | Virtual whiteboard for sketching hand-drawn like diagrams | TypeScript |
| [Tauri](oss/tauri/README.md) | Build smaller, faster, and more secure desktop and mobile applications with a web frontend | Rust |

## Developer Tool

| Project | Description | Language |
|---|---|---|
| [Backstage](oss/backstage/README.md) | An open framework for building developer portals powered by a centralized software catalog | TypeScript |
| [Buf](oss/buf/README.md) | The best way of working with Protocol Buffers, providing linting, breaking change detection, code generation, and Schema Registry integration | Go |
| [Dagger](oss/dagger/README.md) | A programmable CI/CD automation engine that builds, tests and ships any codebase, running locally, in CI, or directly in the cloud | Go |
| [Gitea](oss/gitea/README.md) | Painless self-hosted all-in-one software development service, including Git hosting, code review, team collaboration, package registry and CI/CD | Go |
| [Ruff](oss/ruff/README.md) | An extremely fast Python linter and code formatter, written in Rust | Rust |
| [rust-analyzer](oss/rust-analyzer/README.md) | A Rust compiler front-end for IDEs, providing language server protocol (LSP) support for Rust code intelligence. | Rust |

## Document Processor

| Project | Description | Language |
|---|---|---|
| [Typst](oss/typst/README.md) | A markup-based typesetting system that is powerful and easy to learn | Rust |

## Editor / Terminal

| Project | Description | Language |
|---|---|---|
| [Alacritty](oss/alacritty/README.md) | A fast, cross-platform, OpenGL terminal emulator | Rust |
| [Helix](oss/helix/README.md) | A post-modern modal text editor | Rust |
| [Neovim](oss/neovim/README.md) | Vim-fork focused on extensibility and usability | C (core), Lua (runtime/plugins), Vim Script (legacy) |
| [Nushell](oss/nushell/README.md) | A new type of shell with structured data processing and cross-platform support | Rust |
| [WezTerm](oss/wezterm/README.md) | A GPU-accelerated cross-platform terminal emulator and multiplexer written in Rust | Rust |
| [Zed](oss/zed/README.md) | A high-performance, multiplayer code editor written in Rust with GPU-accelerated UI rendering | Rust |
| [Zellij](oss/zellij/README.md) | A terminal workspace with batteries included - a modern terminal multiplexer featuring WebAssembly plugins and collaborative workflows | Rust |

## Game Engine

| Project | Description | Language |
|---|---|---|
| [Bevy](oss/bevy/README.md) | A refreshingly simple data-driven game engine built in Rust | Rust |

## GitOps

| Project | Description | Language |
|---|---|---|
| [Argo CD](oss/argo-cd/README.md) | Declarative, GitOps-based continuous deployment for Kubernetes | Go |
| [Flux CD v2](oss/flux2/README.md) | Open and extensible continuous delivery solution for Kubernetes powered by GitOps Toolkit | Go |

## IaC

| Project | Description | Language |
|---|---|---|
| [Crossplane](oss/crossplane/README.md) | The Cloud Native Control Plane - A framework for building cloud native control planes without writing code | Go |
| [OpenTofu](oss/opentofu/README.md) | A truly open-source infrastructure as code tool for declaratively managing cloud infrastructure | Go |
| [Terraform](oss/terraform/README.md) | A source-available infrastructure-as-code tool that codifies APIs into declarative configuration files for safe and predictable infrastructure provisioning. | Go |

## Monitoring

| Project | Description | Language |
|---|---|---|
| [Cortex](oss/cortex/README.md) | A horizontally scalable, highly available, multi-tenant, long-term storage solution for Prometheus and OpenTelemetry Metrics | Go |
| [Grafana](oss/grafana/README.md) | The open and composable observability and data visualization platform for metrics, logs, and traces from multiple sources. | TypeScript / Go |
| [Grafana Loki](oss/loki/README.md) | Like Prometheus, but for logs -- a horizontally-scalable, highly-available, multi-tenant log aggregation system | Go |
| [OpenTelemetry Collector](oss/opentelemetry-collector/README.md) | A vendor-agnostic implementation to receive, process, and export telemetry data (traces, metrics, and logs) | Go |
| [Prometheus](oss/prometheus/README.md) | The Prometheus monitoring system and time series database | Go |
| [Thanos](oss/thanos/README.md) | Highly available Prometheus setup with long term storage capabilities | Go |

## Networking

| Project | Description | Language |
|---|---|---|
| [Caddy](oss/caddy/README.md) | Fast and extensible multi-platform HTTP/1-2-3 web server with automatic HTTPS | Go |
| [Cilium](oss/cilium/README.md) | eBPF-based Networking, Security, and Observability for Kubernetes | Go (with C for eBPF programs) |
| [Consul](oss/consul/README.md) | A distributed, highly available, and data center aware solution to connect and configure applications across dynamic, distributed infrastructure. | Go |
| [CoreDNS](oss/coredns/README.md) | A DNS server that chains plugins | Go |
| [Envoy](oss/envoy/README.md) | Cloud-native high-performance edge/middle/service proxy | C++ |
| [Istio](oss/istio/README.md) | Connect, secure, control, and observe services. | Go |
| [Linkerd2](oss/linkerd2/README.md) | Ultralight, security-first service mesh for Kubernetes | Go |
| [Traefik](oss/traefik/README.md) | The Cloud Native Application Proxy - a modern HTTP reverse proxy and load balancer for deploying microservices | Go |

## Runtime

| Project | Description | Language |
|---|---|---|
| [Bun](oss/bun/README.md) | Incredibly fast JavaScript runtime, bundler, test runner, and package manager – all in one | Zig |
| [Dapr](oss/dapr/README.md) | A portable runtime for building distributed applications across cloud and edge, combining event-driven architecture with workflow orchestration | Go |
| [Deno](oss/deno/README.md) | A modern runtime for JavaScript and TypeScript with secure defaults, built on V8, Rust, and Tokio. | Rust |
| [Tokio](oss/tokio/README.md) | A runtime for writing reliable asynchronous applications with Rust, providing I/O, networking, scheduling, and timers. | Rust |
| [Wasmtime](oss/wasmtime/README.md) | A lightweight WebAssembly runtime that is fast, secure, and standards-compliant | Rust |

## Search Engine

| Project | Description | Language |
|---|---|---|
| [Elasticsearch](oss/elasticsearch/README.md) | Free and open source, distributed, RESTful search and analytics engine built on Apache Lucene. | Java |

## Security

| Project | Description | Language |
|---|---|---|
| [Falco](oss/falco/README.md) | Cloud Native Runtime Security tool for Linux operating systems | C++ |
| [Harbor](oss/harbor/README.md) | An open source trusted cloud native registry project that stores, signs, and scans content | Go |
| [HashiCorp Vault](oss/vault/README.md) | A tool for secrets management, encryption as a service, and privileged access management | Go |
| [Keycloak](oss/keycloak/README.md) | Open Source Identity and Access Management For Modern Applications and Services | Java |
| [Trivy](oss/trivy/README.md) | A comprehensive security scanner for containers, Kubernetes, code repositories, and cloud environments | Go |

## Static Site Generator

| Project | Description | Language |
|---|---|---|
| [Hugo](oss/hugo/README.md) | The world's fastest framework for building websites | Go |

## Web Framework

| Project | Description | Language |
|---|---|---|
| [Angular](oss/angular/README.md) | Deliver web apps with confidence - The modern web developer's platform | TypeScript |
| [FastAPI](oss/fastapi/README.md) | A modern, fast (high-performance), web framework for building APIs with Python based on standard Python type hints | Python |
| [Gin](oss/gin/README.md) | A high-performance HTTP web framework for Go, featuring a Martini-like API with up to 40x better performance thanks to a radix tree based router. | Go |
| [Leptos](oss/leptos/README.md) | Build fast web applications with Rust | Rust |
| [NestJS](oss/nestjs/README.md) | A progressive Node.js framework for building efficient, scalable, and enterprise-grade server-side applications with TypeScript/JavaScript | TypeScript |
| [Next.js](oss/nextjs/README.md) | The React Framework for full-stack web applications, extending React with server-side rendering, file-system routing, and Rust-based tooling for the fastest builds. | JavaScript / TypeScript / Rust |
| [Quarkus](oss/quarkus/README.md) | Supersonic Subatomic Java - A Cloud Native, Container First framework for writing Java applications | Java |
| [React](oss/react/README.md) | The library for web and native user interfaces | JavaScript |
| [Remix](oss/remix/README.md) | Build Better Websites. Create modern, resilient user experiences with web fundamentals. | TypeScript |
| [SolidJS](oss/solid/README.md) | A declarative, efficient, and flexible JavaScript library for building user interfaces with fine-grained reactivity | TypeScript |
| [Spring Boot](oss/spring-boot/README.md) | Spring Boot helps you to create Spring-powered, production-grade applications and services with absolute minimum fuss | Java |
| [Svelte](oss/svelte/README.md) | A compiler-first JavaScript framework that converts declarative components into efficient JavaScript that surgically updates the DOM | JavaScript |

## Workflow Engine

| Project | Description | Language |
|---|---|---|
| [Apache Airflow](oss/airflow/README.md) | A platform to programmatically author, schedule, and monitor workflows | Python |
| [Temporal](oss/temporal/README.md) | A durable execution platform that enables developers to build scalable applications without sacrificing productivity or reliability | Go |
