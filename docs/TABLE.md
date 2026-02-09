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
- [Web Server](#web-server)
- [Workflow Engine](#workflow-engine)

## Blockchain

| Project | Description | Language |
|---|---|---|
| [Go Ethereum (Geth)](https://github.com/thxtech/ossarch/blob/main/oss/go-ethereum/README.md) | Official Go implementation of the Ethereum protocol - the execution layer client for the Ethereum blockchain | Go |

## Build Tool

| Project | Description | Language |
|---|---|---|
| [esbuild](https://github.com/thxtech/ossarch/blob/main/oss/esbuild/README.md) | An extremely fast JavaScript and CSS bundler written in Go | Go |
| [SWC](https://github.com/thxtech/ossarch/blob/main/oss/swc/README.md) | Speedy Web Compiler: A super-fast TypeScript/JavaScript compiler written in Rust | Rust |
| [Turborepo](https://github.com/thxtech/ossarch/blob/main/oss/turborepo/README.md) | High-performance build system for JavaScript and TypeScript codebases, written in Rust | Rust |
| [Vite](https://github.com/thxtech/ossarch/blob/main/oss/vite/README.md) | Next generation frontend tooling that provides instant server start and lightning fast Hot Module Replacement (HMR). | TypeScript |

## CLI Tool

| Project | Description | Language |
|---|---|---|
| [fzf](https://github.com/thxtech/ossarch/blob/main/oss/fzf/README.md) | A general-purpose command-line fuzzy finder written in Go | Go |
| [jq](https://github.com/thxtech/ossarch/blob/main/oss/jq/README.md) | Command-line JSON processor | C |
| [Restic](https://github.com/thxtech/ossarch/blob/main/oss/restic/README.md) | Fast, secure, and efficient backup program with content-addressable storage, encryption, and deduplication | Go |
| [ripgrep](https://github.com/thxtech/ossarch/blob/main/oss/ripgrep/README.md) | ripgrep recursively searches directories for a regex pattern while respecting your gitignore | Rust |
| [Starship](https://github.com/thxtech/ossarch/blob/main/oss/starship/README.md) | The minimal, blazing-fast, and infinitely customizable prompt for any shell | Rust |

## Cloud Platform

| Project | Description | Language |
|---|---|---|
| [Supabase](https://github.com/thxtech/ossarch/blob/main/oss/supabase/README.md) | The open-source Postgres development platform -- building Firebase-like features using enterprise-grade open-source tools on top of PostgreSQL. | TypeScript |

## Container Orchestration

| Project | Description | Language |
|---|---|---|
| [Docker Compose](https://github.com/thxtech/ossarch/blob/main/oss/compose/README.md) | Define and run multi-container applications with Docker | Go |
| [Helm](https://github.com/thxtech/ossarch/blob/main/oss/helm/README.md) | The Kubernetes Package Manager | Go |
| [k3s](https://github.com/thxtech/ossarch/blob/main/oss/k3s/README.md) | Lightweight, fully conformant Kubernetes distribution for resource-constrained environments | Go |
| [Kubernetes](https://github.com/thxtech/ossarch/blob/main/oss/kubernetes/README.md) | Production-grade container scheduling and management system for automating deployment, scaling, and operations of application containers across clusters of hosts. | Go |
| [Nomad](https://github.com/thxtech/ossarch/blob/main/oss/nomad/README.md) | A simple and flexible workload orchestrator to deploy and manage containers, non-containerized applications, and virtual machines across on-prem and clouds at scale | Go |

## Container Runtime

| Project | Description | Language |
|---|---|---|
| [containerd](https://github.com/thxtech/ossarch/blob/main/oss/containerd/README.md) | An industry-standard container runtime with an emphasis on simplicity, robustness, and portability | Go |
| [Moby (Docker Engine)](https://github.com/thxtech/ossarch/blob/main/oss/moby/README.md) | The Moby Project - a collaborative project for the container ecosystem to assemble container-based systems | Go |
| [Podman](https://github.com/thxtech/ossarch/blob/main/oss/podman/README.md) | A daemonless tool for managing OCI containers, pods, and images with Docker-compatible CLI | Go |

## Data Processing

| Project | Description | Language |
|---|---|---|
| [Apache Arrow](https://github.com/thxtech/ossarch/blob/main/oss/arrow/README.md) | Universal columnar format and multi-language toolbox for fast data interchange and in-memory analytics | C++ |
| [Apache Flink](https://github.com/thxtech/ossarch/blob/main/oss/flink/README.md) | A distributed stream processing framework for stateful computations over unbounded and bounded data streams | Java |
| [Apache Kafka](https://github.com/thxtech/ossarch/blob/main/oss/kafka/README.md) | A distributed event streaming platform for high-throughput, fault-tolerant data pipelines and real-time analytics | Java |
| [Apache Pulsar](https://github.com/thxtech/ossarch/blob/main/oss/pulsar/README.md) | A distributed pub-sub messaging platform with multi-tenancy and geo-replication built-in | Java |
| [Apache Spark](https://github.com/thxtech/ossarch/blob/main/oss/spark/README.md) | A unified analytics engine for large-scale data processing | Scala |
| [FFmpeg](https://github.com/thxtech/ossarch/blob/main/oss/ffmpeg/README.md) | A complete cross-platform solution for recording, converting, and streaming audio and video with a comprehensive library of codecs, formats, and filters | C |
| [NATS Server](https://github.com/thxtech/ossarch/blob/main/oss/nats-server/README.md) | High-performance server for NATS.io, the cloud and edge native messaging system. | Go |
| [Polars](https://github.com/thxtech/ossarch/blob/main/oss/polars/README.md) | Extremely fast Query Engine for DataFrames, written in Rust | Rust |
| [PyTorch](https://github.com/thxtech/ossarch/blob/main/oss/pytorch/README.md) | Tensors and dynamic neural networks in Python with strong GPU acceleration, providing a flexible deep learning framework with an imperative programming model. | Python |
| [RabbitMQ](https://github.com/thxtech/ossarch/blob/main/oss/rabbitmq-server/README.md) | Open-source message broker implementing AMQP, MQTT, and STOMP protocols for reliable asynchronous messaging | Erlang |
| [Ray](https://github.com/thxtech/ossarch/blob/main/oss/ray/README.md) | A unified framework for scaling AI and Python applications with distributed computing | Python |

## Database

| Project | Description | Language |
|---|---|---|
| [Apache Cassandra](https://github.com/thxtech/ossarch/blob/main/oss/cassandra/README.md) | A highly scalable, distributed NoSQL database designed for handling large amounts of data across many commodity servers with no single point of failure. | Java |
| [Badger](https://github.com/thxtech/ossarch/blob/main/oss/badger/README.md) | High-performance, embeddable key-value store written in pure Go based on the WiscKey architecture | Go |
| [Ceph](https://github.com/thxtech/ossarch/blob/main/oss/ceph/README.md) | Distributed storage system providing object, block, and file storage in a single unified platform | C++ |
| [ClickHouse](https://github.com/thxtech/ossarch/blob/main/oss/clickhouse/README.md) | A real-time analytics database management system with column-oriented storage architecture | C++ |
| [CockroachDB](https://github.com/thxtech/ossarch/blob/main/oss/cockroachdb/README.md) | A cloud-native, distributed SQL database designed for high availability, effortless scale, and control over data placement. | Go |
| [Dgraph](https://github.com/thxtech/ossarch/blob/main/oss/dgraph/README.md) | A horizontally scalable and distributed GraphQL database with a graph backend | Go |
| [Dragonfly](https://github.com/thxtech/ossarch/blob/main/oss/dragonfly/README.md) | A modern replacement for Redis and Memcached with a multi-threaded, shared-nothing architecture | C++ |
| [DuckDB](https://github.com/thxtech/ossarch/blob/main/oss/duckdb/README.md) | An in-process analytical SQL database management system for OLAP workloads | C++ |
| [etcd](https://github.com/thxtech/ossarch/blob/main/oss/etcd/README.md) | Distributed reliable key-value store for the most critical data of a distributed system | Go |
| [FoundationDB](https://github.com/thxtech/ossarch/blob/main/oss/foundationdb/README.md) | A distributed, transactional key-value store designed to handle large volumes of structured data across clusters of commodity servers, with industry-leading correctness guarantees through deterministic simulation testing. | C++ |
| [InfluxDB](https://github.com/thxtech/ossarch/blob/main/oss/influxdb/README.md) | Scalable datastore for metrics, events, and real-time analytics | Rust |
| [JuiceFS](https://github.com/thxtech/ossarch/blob/main/oss/juicefs/README.md) | High-performance, POSIX-compatible distributed filesystem built on top of object storage and metadata engines | Go |
| [MinIO](https://github.com/thxtech/ossarch/blob/main/oss/minio/README.md) | A high-performance, S3-compatible object storage solution for AI/ML, analytics, and data-intensive workloads | Go |
| [MongoDB](https://github.com/thxtech/ossarch/blob/main/oss/mongodb/README.md) | The most popular document-oriented NoSQL database, designed for scalability and developer productivity. | C++ |
| [Neon](https://github.com/thxtech/ossarch/blob/main/oss/neon/README.md) | Serverless Postgres with separated storage and compute offering autoscaling, branching, and scale to zero | Rust |
| [Pebble](https://github.com/thxtech/ossarch/blob/main/oss/pebble/README.md) | LevelDB/RocksDB-inspired key-value store in Go, the primary storage engine for CockroachDB | Go |
| [PostgreSQL](https://github.com/thxtech/ossarch/blob/main/oss/postgresql/README.md) | The world's most advanced open source relational database management system. | C |
| [Qdrant](https://github.com/thxtech/ossarch/blob/main/oss/qdrant/README.md) | High-performance, massive-scale Vector Database and Vector Search Engine for the next generation of AI | Rust |
| [Redis](https://github.com/thxtech/ossarch/blob/main/oss/redis/README.md) | The preferred, fastest, and most feature-rich in-memory data structure server, cache, and real-time data engine for developers building data-driven applications. | C |
| [RocksDB](https://github.com/thxtech/ossarch/blob/main/oss/rocksdb/README.md) | A library that provides an embeddable, persistent key-value store for fast storage | C++ |
| [Rook](https://github.com/thxtech/ossarch/blob/main/oss/rook/README.md) | Storage Orchestration for Kubernetes | Go |
| [ScyllaDB](https://github.com/thxtech/ossarch/blob/main/oss/scylladb/README.md) | A high-performance NoSQL database compatible with Apache Cassandra and Amazon DynamoDB, built on the Seastar framework with a shard-per-core architecture. | C++ |
| [SurrealDB](https://github.com/thxtech/ossarch/blob/main/oss/surrealdb/README.md) | A scalable, distributed, collaborative, document-graph database for the realtime web | Rust |
| [TiDB](https://github.com/thxtech/ossarch/blob/main/oss/tidb/README.md) | An open-source, cloud-native, distributed SQL database designed for modern applications | Go |
| [TiKV](https://github.com/thxtech/ossarch/blob/main/oss/tikv/README.md) | A distributed transactional key-value database powered by Rust and Raft, originally created to complement TiDB | Rust |
| [Valkey](https://github.com/thxtech/ossarch/blob/main/oss/valkey/README.md) | A flexible distributed key-value database optimized for caching and other realtime workloads | C |
| [Vitess](https://github.com/thxtech/ossarch/blob/main/oss/vitess/README.md) | A cloud-native horizontally-scalable distributed database system built around MySQL | Go |
| [Weaviate](https://github.com/thxtech/ossarch/blob/main/oss/weaviate/README.md) | An open-source, cloud-native vector database that stores both objects and vectors, enabling semantic search and RAG applications at scale | Go |
| [YugabyteDB](https://github.com/thxtech/ossarch/blob/main/oss/yugabytedb/README.md) | The cloud native distributed SQL database for mission-critical applications | C / C++ |

## Desktop Application

| Project | Description | Language |
|---|---|---|
| [Electron](https://github.com/thxtech/ossarch/blob/main/oss/electron/README.md) | Build cross-platform desktop apps with JavaScript, HTML, and CSS | C++ |
| [Excalidraw](https://github.com/thxtech/ossarch/blob/main/oss/excalidraw/README.md) | Virtual whiteboard for sketching hand-drawn like diagrams | TypeScript |
| [Tauri](https://github.com/thxtech/ossarch/blob/main/oss/tauri/README.md) | Build smaller, faster, and more secure desktop and mobile applications with a web frontend | Rust |

## Developer Tool

| Project | Description | Language |
|---|---|---|
| [Backstage](https://github.com/thxtech/ossarch/blob/main/oss/backstage/README.md) | An open framework for building developer portals powered by a centralized software catalog | TypeScript |
| [Buf](https://github.com/thxtech/ossarch/blob/main/oss/buf/README.md) | The best way of working with Protocol Buffers, providing linting, breaking change detection, code generation, and Schema Registry integration | Go |
| [Dagger](https://github.com/thxtech/ossarch/blob/main/oss/dagger/README.md) | A programmable CI/CD automation engine that builds, tests and ships any codebase, running locally, in CI, or directly in the cloud | Go |
| [Flutter](https://github.com/thxtech/ossarch/blob/main/oss/flutter/README.md) | Flutter makes it easy and fast to build beautiful apps for mobile and beyond | Dart |
| [Gitea](https://github.com/thxtech/ossarch/blob/main/oss/gitea/README.md) | Painless self-hosted all-in-one software development service, including Git hosting, code review, team collaboration, package registry and CI/CD | Go |
| [Ollama](https://github.com/thxtech/ossarch/blob/main/oss/ollama/README.md) | Get up and running with large language models locally, providing a streamlined interface for downloading, managing, and running LLMs on personal hardware. | Go |
| [Ruff](https://github.com/thxtech/ossarch/blob/main/oss/ruff/README.md) | An extremely fast Python linter and code formatter, written in Rust | Rust |
| [rust-analyzer](https://github.com/thxtech/ossarch/blob/main/oss/rust-analyzer/README.md) | A Rust compiler front-end for IDEs, providing language server protocol (LSP) support for Rust code intelligence. | Rust |

## Document Processor

| Project | Description | Language |
|---|---|---|
| [Typst](https://github.com/thxtech/ossarch/blob/main/oss/typst/README.md) | A markup-based typesetting system that is powerful and easy to learn | Rust |

## Editor / Terminal

| Project | Description | Language |
|---|---|---|
| [Alacritty](https://github.com/thxtech/ossarch/blob/main/oss/alacritty/README.md) | A fast, cross-platform, OpenGL terminal emulator | Rust |
| [Helix](https://github.com/thxtech/ossarch/blob/main/oss/helix/README.md) | A post-modern modal text editor | Rust |
| [Neovim](https://github.com/thxtech/ossarch/blob/main/oss/neovim/README.md) | Vim-fork focused on extensibility and usability | C (core), Lua (runtime/plugins), Vim Script (legacy) |
| [Nushell](https://github.com/thxtech/ossarch/blob/main/oss/nushell/README.md) | A new type of shell with structured data processing and cross-platform support | Rust |
| [WezTerm](https://github.com/thxtech/ossarch/blob/main/oss/wezterm/README.md) | A GPU-accelerated cross-platform terminal emulator and multiplexer written in Rust | Rust |
| [Zed](https://github.com/thxtech/ossarch/blob/main/oss/zed/README.md) | A high-performance, multiplayer code editor written in Rust with GPU-accelerated UI rendering | Rust |
| [Zellij](https://github.com/thxtech/ossarch/blob/main/oss/zellij/README.md) | A terminal workspace with batteries included - a modern terminal multiplexer featuring WebAssembly plugins and collaborative workflows | Rust |

## Game Engine

| Project | Description | Language |
|---|---|---|
| [Bevy](https://github.com/thxtech/ossarch/blob/main/oss/bevy/README.md) | A refreshingly simple data-driven game engine built in Rust | Rust |
| [Godot](https://github.com/thxtech/ossarch/blob/main/oss/godot/README.md) | Multi-platform 2D and 3D game engine with an integrated development environment and its own scripting language | C++ |

## GitOps

| Project | Description | Language |
|---|---|---|
| [Argo CD](https://github.com/thxtech/ossarch/blob/main/oss/argo-cd/README.md) | Declarative, GitOps-based continuous deployment for Kubernetes | Go |
| [Flux CD v2](https://github.com/thxtech/ossarch/blob/main/oss/flux2/README.md) | Open and extensible continuous delivery solution for Kubernetes powered by GitOps Toolkit | Go |

## IaC

| Project | Description | Language |
|---|---|---|
| [Ansible](https://github.com/thxtech/ossarch/blob/main/oss/ansible/README.md) | Radically simple IT automation platform for application deployment, configuration management, and orchestration | Python |
| [Crossplane](https://github.com/thxtech/ossarch/blob/main/oss/crossplane/README.md) | The Cloud Native Control Plane - A framework for building cloud native control planes without writing code | Go |
| [OpenTofu](https://github.com/thxtech/ossarch/blob/main/oss/opentofu/README.md) | A truly open-source infrastructure as code tool for declaratively managing cloud infrastructure | Go |
| [Terraform](https://github.com/thxtech/ossarch/blob/main/oss/terraform/README.md) | A source-available infrastructure-as-code tool that codifies APIs into declarative configuration files for safe and predictable infrastructure provisioning. | Go |

## Monitoring

| Project | Description | Language |
|---|---|---|
| [Cortex](https://github.com/thxtech/ossarch/blob/main/oss/cortex/README.md) | A horizontally scalable, highly available, multi-tenant, long-term storage solution for Prometheus and OpenTelemetry Metrics | Go |
| [Grafana](https://github.com/thxtech/ossarch/blob/main/oss/grafana/README.md) | The open and composable observability and data visualization platform for metrics, logs, and traces from multiple sources. | TypeScript / Go |
| [Grafana Loki](https://github.com/thxtech/ossarch/blob/main/oss/loki/README.md) | Like Prometheus, but for logs -- a horizontally-scalable, highly-available, multi-tenant log aggregation system | Go |
| [Jaeger](https://github.com/thxtech/ossarch/blob/main/oss/jaeger/README.md) | CNCF distributed tracing platform for monitoring and troubleshooting microservice architectures | Go |
| [OpenTelemetry Collector](https://github.com/thxtech/ossarch/blob/main/oss/opentelemetry-collector/README.md) | A vendor-agnostic implementation to receive, process, and export telemetry data (traces, metrics, and logs) | Go |
| [Prometheus](https://github.com/thxtech/ossarch/blob/main/oss/prometheus/README.md) | The Prometheus monitoring system and time series database | Go |
| [Thanos](https://github.com/thxtech/ossarch/blob/main/oss/thanos/README.md) | Highly available Prometheus setup with long term storage capabilities | Go |
| [Vector](https://github.com/thxtech/ossarch/blob/main/oss/vector/README.md) | High-performance observability data pipeline for collecting, transforming, and routing logs, metrics, and traces | Rust |

## Networking

| Project | Description | Language |
|---|---|---|
| [Caddy](https://github.com/thxtech/ossarch/blob/main/oss/caddy/README.md) | Fast and extensible multi-platform HTTP/1-2-3 web server with automatic HTTPS | Go |
| [Cilium](https://github.com/thxtech/ossarch/blob/main/oss/cilium/README.md) | eBPF-based Networking, Security, and Observability for Kubernetes | Go (with C for eBPF programs) |
| [Consul](https://github.com/thxtech/ossarch/blob/main/oss/consul/README.md) | A distributed, highly available, and data center aware solution to connect and configure applications across dynamic, distributed infrastructure. | Go |
| [CoreDNS](https://github.com/thxtech/ossarch/blob/main/oss/coredns/README.md) | A DNS server that chains plugins | Go |
| [Envoy](https://github.com/thxtech/ossarch/blob/main/oss/envoy/README.md) | Cloud-native high-performance edge/middle/service proxy | C++ |
| [ExternalDNS](https://github.com/thxtech/ossarch/blob/main/oss/external-dns/README.md) | Automatic DNS record management for Kubernetes resources | Go |
| [gRPC](https://github.com/thxtech/ossarch/blob/main/oss/grpc/README.md) | High-performance, open-source universal RPC framework built on HTTP/2 and Protocol Buffers | C++ |
| [Istio](https://github.com/thxtech/ossarch/blob/main/oss/istio/README.md) | Connect, secure, control, and observe services. | Go |
| [Linkerd2](https://github.com/thxtech/ossarch/blob/main/oss/linkerd2/README.md) | Ultralight, security-first service mesh for Kubernetes | Go |
| [Traefik](https://github.com/thxtech/ossarch/blob/main/oss/traefik/README.md) | The Cloud Native Application Proxy - a modern HTTP reverse proxy and load balancer for deploying microservices | Go |

## Runtime

| Project | Description | Language |
|---|---|---|
| [Bun](https://github.com/thxtech/ossarch/blob/main/oss/bun/README.md) | Incredibly fast JavaScript runtime, bundler, test runner, and package manager – all in one | Zig |
| [CPython](https://github.com/thxtech/ossarch/blob/main/oss/cpython/README.md) | The reference implementation of the Python programming language | Python |
| [Dapr](https://github.com/thxtech/ossarch/blob/main/oss/dapr/README.md) | A portable runtime for building distributed applications across cloud and edge, combining event-driven architecture with workflow orchestration | Go |
| [Deno](https://github.com/thxtech/ossarch/blob/main/oss/deno/README.md) | A modern runtime for JavaScript and TypeScript with secure defaults, built on V8, Rust, and Tokio. | Rust |
| [Tokio](https://github.com/thxtech/ossarch/blob/main/oss/tokio/README.md) | A runtime for writing reliable asynchronous applications with Rust, providing I/O, networking, scheduling, and timers. | Rust |
| [Wasmtime](https://github.com/thxtech/ossarch/blob/main/oss/wasmtime/README.md) | A lightweight WebAssembly runtime that is fast, secure, and standards-compliant | Rust |
| [Zig](https://github.com/thxtech/ossarch/blob/main/oss/zig/README.md) | General-purpose systems programming language and toolchain designed for robust, optimal, and reusable software with comptime evaluation and a self-hosted compiler | Zig |

## Search Engine

| Project | Description | Language |
|---|---|---|
| [Elasticsearch](https://github.com/thxtech/ossarch/blob/main/oss/elasticsearch/README.md) | Free and open source, distributed, RESTful search and analytics engine built on Apache Lucene. | Java |
| [Meilisearch](https://github.com/thxtech/ossarch/blob/main/oss/meilisearch/README.md) | Lightning-fast, typo-tolerant search engine providing full-text, semantic, and hybrid search via RESTful API | Rust |
| [Typesense](https://github.com/thxtech/ossarch/blob/main/oss/typesense/README.md) | Open-source, typo-tolerant, in-memory search engine optimized for instant search experiences with a simple RESTful API | C++ |

## Security

| Project | Description | Language |
|---|---|---|
| [cert-manager](https://github.com/thxtech/ossarch/blob/main/oss/cert-manager/README.md) | Kubernetes-native certificate management controller for automated TLS certificate lifecycle | Go |
| [Cosign](https://github.com/thxtech/ossarch/blob/main/oss/cosign/README.md) | Container image signing and verification for software supply chain security | Go |
| [Falco](https://github.com/thxtech/ossarch/blob/main/oss/falco/README.md) | Cloud Native Runtime Security tool for Linux operating systems | C++ |
| [Harbor](https://github.com/thxtech/ossarch/blob/main/oss/harbor/README.md) | An open source trusted cloud native registry project that stores, signs, and scans content | Go |
| [HashiCorp Vault](https://github.com/thxtech/ossarch/blob/main/oss/vault/README.md) | A tool for secrets management, encryption as a service, and privileged access management | Go |
| [Keycloak](https://github.com/thxtech/ossarch/blob/main/oss/keycloak/README.md) | Open Source Identity and Access Management For Modern Applications and Services | Java |
| [Kyverno](https://github.com/thxtech/ossarch/blob/main/oss/kyverno/README.md) | Kubernetes-native policy management for security, compliance, and operational best practices | Go |
| [OPA (Open Policy Agent)](https://github.com/thxtech/ossarch/blob/main/oss/opa/README.md) | General-purpose policy engine for unified policy enforcement across the stack | Go |
| [SPIRE](https://github.com/thxtech/ossarch/blob/main/oss/spire/README.md) | SPIFFE Runtime Environment for workload identity in distributed systems | Go |
| [Trivy](https://github.com/thxtech/ossarch/blob/main/oss/trivy/README.md) | A comprehensive security scanner for containers, Kubernetes, code repositories, and cloud environments | Go |

## Static Site Generator

| Project | Description | Language |
|---|---|---|
| [Hugo](https://github.com/thxtech/ossarch/blob/main/oss/hugo/README.md) | The world's fastest framework for building websites | Go |

## Web Framework

| Project | Description | Language |
|---|---|---|
| [Angular](https://github.com/thxtech/ossarch/blob/main/oss/angular/README.md) | Deliver web apps with confidence - The modern web developer's platform | TypeScript |
| [Astro](https://github.com/thxtech/ossarch/blob/main/oss/astro/README.md) | A content-focused web framework pioneering the Islands Architecture for optimal performance | TypeScript |
| [Django](https://github.com/thxtech/ossarch/blob/main/oss/django/README.md) | The Web framework for perfectionists with deadlines, providing a high-level Python framework that encourages rapid development and clean, pragmatic design. | Python |
| [Express](https://github.com/thxtech/ossarch/blob/main/oss/express/README.md) | Fast, unopinionated, minimalist web framework for Node.js, providing a thin layer of fundamental web application features. | JavaScript |
| [FastAPI](https://github.com/thxtech/ossarch/blob/main/oss/fastapi/README.md) | A modern, fast (high-performance), web framework for building APIs with Python based on standard Python type hints | Python |
| [Gin](https://github.com/thxtech/ossarch/blob/main/oss/gin/README.md) | A high-performance HTTP web framework for Go, featuring a Martini-like API with up to 40x better performance thanks to a radix tree based router. | Go |
| [Hono](https://github.com/thxtech/ossarch/blob/main/oss/hono/README.md) | Ultrafast, lightweight web framework built on Web Standards APIs for any JavaScript runtime | TypeScript |
| [htmx](https://github.com/thxtech/ossarch/blob/main/oss/htmx/README.md) | A JavaScript library extending HTML with AJAX capabilities through declarative attributes | JavaScript |
| [Leptos](https://github.com/thxtech/ossarch/blob/main/oss/leptos/README.md) | Build fast web applications with Rust | Rust |
| [NestJS](https://github.com/thxtech/ossarch/blob/main/oss/nestjs/README.md) | A progressive Node.js framework for building efficient, scalable, and enterprise-grade server-side applications with TypeScript/JavaScript | TypeScript |
| [Next.js](https://github.com/thxtech/ossarch/blob/main/oss/nextjs/README.md) | The React Framework for full-stack web applications, extending React with server-side rendering, file-system routing, and Rust-based tooling for the fastest builds. | JavaScript / TypeScript / Rust |
| [Nuxt](https://github.com/thxtech/ossarch/blob/main/oss/nuxt/README.md) | The full-stack Vue.js meta-framework for universal web applications | TypeScript |
| [Quarkus](https://github.com/thxtech/ossarch/blob/main/oss/quarkus/README.md) | Supersonic Subatomic Java - A Cloud Native, Container First framework for writing Java applications | Java |
| [React](https://github.com/thxtech/ossarch/blob/main/oss/react/README.md) | The library for web and native user interfaces | JavaScript |
| [Remix](https://github.com/thxtech/ossarch/blob/main/oss/remix/README.md) | Build Better Websites. Create modern, resilient user experiences with web fundamentals. | TypeScript |
| [Ruby on Rails](https://github.com/thxtech/ossarch/blob/main/oss/rails/README.md) | Full-stack web application framework with convention over configuration | Ruby |
| [SolidJS](https://github.com/thxtech/ossarch/blob/main/oss/solid/README.md) | A declarative, efficient, and flexible JavaScript library for building user interfaces with fine-grained reactivity | TypeScript |
| [Spring Boot](https://github.com/thxtech/ossarch/blob/main/oss/spring-boot/README.md) | Spring Boot helps you to create Spring-powered, production-grade applications and services with absolute minimum fuss | Java |
| [Svelte](https://github.com/thxtech/ossarch/blob/main/oss/svelte/README.md) | A compiler-first JavaScript framework that converts declarative components into efficient JavaScript that surgically updates the DOM | JavaScript |

## Web Server

| Project | Description | Language |
|---|---|---|
| [nginx](https://github.com/thxtech/ossarch/blob/main/oss/nginx/README.md) | High-performance HTTP server, reverse proxy, and load balancer built on an event-driven, non-blocking architecture. | C |

## Workflow Engine

| Project | Description | Language |
|---|---|---|
| [Apache Airflow](https://github.com/thxtech/ossarch/blob/main/oss/airflow/README.md) | A platform to programmatically author, schedule, and monitor workflows | Python |
| [Temporal](https://github.com/thxtech/ossarch/blob/main/oss/temporal/README.md) | A durable execution platform that enables developers to build scalable applications without sacrificing productivity or reliability | Go |
