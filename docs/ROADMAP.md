# Learning Roadmap

This guide helps you navigate the architecture reports in this repository based on your experience level and learning goals. Each project link leads to a detailed architecture analysis covering design decisions, data flow, and key takeaways.

## How to Use This Roadmap

Start with the difficulty level that matches your background. Within each level, pick a project in a domain you care about. Read the architecture report, paying special attention to the "Key Design Decisions" and "Key Takeaways" sections. Then move on to the next level or explore a themed learning path.

---

## Beginner

Projects with focused scope, clean codebases, and straightforward architectures. Great for learning fundamental patterns like event loops, plugin systems, and middleware chains.

| Project | Why Start Here |
|---|---|
| [fzf](../oss/fzf/README.md) | Compact Go codebase demonstrating event-driven concurrency and pipeline architecture in a single-purpose CLI tool |
| [starship](../oss/starship/README.md) | Clean modular Rust design with parallel execution, lazy evaluation, and a well-defined plugin interface |
| [gin](../oss/gin/README.md) | Minimal web framework showing radix tree routing, middleware chains, and object pooling in under 10K lines of Go |
| [hugo](../oss/hugo/README.md) | Static site generator with clear separation of content processing, templating, and asset pipelines |
| [caddy](../oss/caddy/README.md) | Modular web server with an elegant module registry, lifecycle hooks, and automatic HTTPS by default |
| [coredns](../oss/coredns/README.md) | DNS server built on a plugin chain architecture forked from Caddy, showing how to adapt a framework for a new domain |
| [fastapi](../oss/fastapi/README.md) | Python web framework demonstrating dependency injection, type-driven validation, and async request handling |
| [esbuild](../oss/esbuild/README.md) | JavaScript bundler written in Go with a focus on raw performance through parallelism and minimal allocations |
| [ruff](../oss/ruff/README.md) | Python linter in Rust showing how to apply compiler techniques (parsing, AST traversal) to developer tooling |
| [vite](../oss/vite/README.md) | Frontend build tool demonstrating native ES module serving and on-demand compilation for fast development cycles |
| [excalidraw](../oss/excalidraw/README.md) | Hand-drawn style diagramming tool with a simple React canvas architecture and collaborative editing |

## Intermediate

Projects with multiple interacting subsystems, distributed components, or sophisticated internal data structures. Good for learning about storage engines, query languages, networking stacks, and orchestration patterns.

| Project | What You Will Learn |
|---|---|
| [redis](../oss/redis/README.md) | Single-threaded event loop design, in-memory data structures, persistence strategies (RDB/AOF), and replication |
| [prometheus](../oss/prometheus/README.md) | Pull-based monitoring architecture, custom TSDB with LSM-like compaction, PromQL query engine, and service discovery |
| [envoy](../oss/envoy/README.md) | L4/L7 proxy with filter chain architecture, xDS dynamic configuration, and hot-restart for zero-downtime upgrades |
| [react](../oss/react/README.md) | Fiber-based reconciliation engine, concurrent rendering with priority scheduling, and the virtual DOM diffing algorithm |
| [containerd](../oss/containerd/README.md) | Container runtime with gRPC API, shim-based process isolation, snapshot-based storage, and CRI plugin integration |
| [etcd](../oss/etcd/README.md) | Distributed key-value store using Raft consensus, MVCC storage, and watch notification streams |
| [grafana](../oss/grafana/README.md) | Observability platform with plugin architecture, data source abstraction, and dashboard rendering pipeline |
| [traefik](../oss/traefik/README.md) | Cloud-native reverse proxy with automatic service discovery, dynamic configuration, and middleware chains |
| [helm](../oss/helm/README.md) | Kubernetes package manager demonstrating Go templating, release lifecycle management, and chart dependency resolution |
| [clickhouse](../oss/clickhouse/README.md) | Column-oriented OLAP database with vectorized query execution, MergeTree storage engine, and distributed query planning |
| [alacritty](../oss/alacritty/README.md) | GPU-accelerated terminal emulator with VTE parser, PTY integration, and a modular rendering pipeline |
| [backstage](../oss/backstage/README.md) | Developer portal with plugin-based architecture, software catalog model, and frontend/backend separation |
| [bevy](../oss/bevy/README.md) | ECS-based game engine with parallel system scheduling, modular plugin architecture, and Rust compile-time guarantees |
| [buf](../oss/buf/README.md) | Protobuf toolchain with multi-layer architecture spanning CLI, compiler, linter, and schema registry integration |
| [dapr](../oss/dapr/README.md) | Microservice sidecar runtime with building block abstractions, pluggable components, and control plane integration |
| [duckdb](../oss/duckdb/README.md) | In-process analytical database with vectorized execution engine, cost-based query optimizer, and columnar storage |
| [falco](../oss/falco/README.md) | Runtime security tool using kernel-level event capture via eBPF, rule engine, and event enrichment pipeline |
| [gitea](../oss/gitea/README.md) | Self-hosted Git service with layered architecture, multi-database support, and Gitea Actions integration |
| [harbor](../oss/harbor/README.md) | Container registry with microservice architecture, replication engine, scanner integration, and policy management |
| [helix](../oss/helix/README.md) | Modal text editor with Tree-sitter integration, LSP client, and ropey-based rope data structure for text manipulation |
| [leptos](../oss/leptos/README.md) | Fine-grained reactive Rust web framework with isomorphic server functions and SSR/CSR support |
| [nats-server](../oss/nats-server/README.md) | High-performance messaging system with JetStream persistence, Raft consensus, and multi-cluster support |
| [nestjs](../oss/nestjs/README.md) | Enterprise Node.js framework with dependency injection container, modular architecture, and decorator-based metadata |
| [nushell](../oss/nushell/README.md) | Structured data shell with custom type system, pipeline engine, and plugin architecture for object-based pipelines |
| [remix](../oss/remix/README.md) | Web standards-based framework with composable package architecture and fetch-based routing |
| [rook](../oss/rook/README.md) | Kubernetes operator for Ceph storage with custom controllers for monitors, OSDs, and CSI driver integration |
| [solid](../oss/solid/README.md) | Fine-grained reactive framework with compile-time JSX transformation and direct DOM manipulation without virtual DOM |
| [spring-boot](../oss/spring-boot/README.md) | Auto-configuration framework with conditional bean registration, embedded server support, and plugin-based build tooling |
| [supabase](../oss/supabase/README.md) | Postgres platform integrating multiple open-source services via Kong gateway with unified auth and storage layers |
| [tauri](../oss/tauri/README.md) | Cross-platform desktop app framework with strict IPC separation, runtime abstraction, and ACL security layer |
| [trivy](../oss/trivy/README.md) | Security scanner with modular artifact analysis, multiple scanner types, and unified detection pipeline |
| [turborepo](../oss/turborepo/README.md) | Monorepo build system with task graph execution, remote caching, and lockfile-based dependency analysis |
| [typst](../oss/typst/README.md) | Incremental typesetting system with four-phase compilation pipeline and comemo memoization framework |
| [wezterm](../oss/wezterm/README.md) | GPU-accelerated terminal emulator with HarfBuzz font shaping, multiplexing layer, and Lua configuration |
| [zellij](../oss/zellij/README.md) | Terminal multiplexer with multi-threaded architecture, WebAssembly plugin system, and Unix socket IPC |

## Advanced

Large-scale distributed systems with complex consensus protocols, multi-layer architectures, and sophisticated failure handling. For developers ready to study production-grade distributed systems design.

| Project | Core Complexity |
|---|---|
| [kubernetes](../oss/kubernetes/README.md) | Declarative desired-state reconciliation, controller pattern, custom resource extensions, and multi-component distributed architecture |
| [kafka](../oss/kafka/README.md) | Distributed commit log with partition-based parallelism, ISR replication, exactly-once semantics, and the KRaft consensus layer |
| [cockroachdb](../oss/cockroachdb/README.md) | Distributed SQL with Raft-based replication, MVCC transactions, range-based sharding, and geo-partitioning |
| [spark](../oss/spark/README.md) | DAG-based execution engine with Catalyst query optimizer, Tungsten memory management, and adaptive query execution |
| [elasticsearch](../oss/elasticsearch/README.md) | Distributed search with Lucene-based inverted indices, shard allocation, near-real-time indexing, and a rich query DSL |
| [tidb](../oss/tidb/README.md) | MySQL-compatible distributed database with TiKV storage layer, Raft groups, and cost-based query optimization |
| [vitess](../oss/vitess/README.md) | MySQL horizontal scaling through vtgate query routing, vttablet connection pooling, and topology-aware sharding |
| [istio](../oss/istio/README.md) | Service mesh control plane with Envoy data plane integration, mTLS certificate management, and traffic policy enforcement |
| [ray](../oss/ray/README.md) | Distributed computing framework with task and actor abstractions, GCS-based fault tolerance, and object store for data sharing |
| [temporal](../oss/temporal/README.md) | Durable execution platform with event-sourced workflow history, deterministic replay, and multi-cluster replication |
| [airflow](../oss/airflow/README.md) | Distributed workflow orchestration with DAG scheduling, pluggable executors, and multi-component architecture |
| [angular](../oss/angular/README.md) | Full-featured frontend framework with Ivy rendering engine, hierarchical DI, Signals reactivity, and AOT/JIT compilation |
| [bun](../oss/bun/README.md) | Unified JavaScript runtime, bundler, transpiler, test runner, and package manager implemented in Zig with JavaScriptCore |
| [consul](../oss/consul/README.md) | Distributed service networking with Raft consensus, Serf gossip protocol, and service mesh capabilities |
| [cortex](../oss/cortex/README.md) | Horizontally scalable Prometheus long-term storage with multi-tenancy, distributed components, and erasure coding |
| [deno](../oss/deno/README.md) | Secure JavaScript/TypeScript runtime in Rust with V8, TypeScript integration, and Node.js compatibility layer |
| [dgraph](../oss/dgraph/README.md) | Distributed GraphQL database with Raft consensus, predicate-based sharding, and BadgerDB storage engine |
| [go-ethereum](../oss/go-ethereum/README.md) | Ethereum protocol implementation with EVM, Merkle Patricia Trie state management, and multiple sync modes |
| [influxdb](../oss/influxdb/README.md) | Time-series database with FDAP stack, WAL, Parquet persistence, and DataFusion query engine integration |
| [keycloak](../oss/keycloak/README.md) | IAM solution with multi-protocol support (OIDC/SAML/OAuth2), SPI-driven architecture, and Infinispan distributed caching |
| [minio](../oss/minio/README.md) | S3-compatible object storage with erasure coding, distributed architecture, and multi-pool management |
| [neovim](../oss/neovim/README.md) | Extensible editor with libuv event loop, MessagePack-RPC API, embedded Lua runtime, and built-in LSP/Tree-sitter |
| [nomad](../oss/nomad/README.md) | Workload orchestrator with Raft consensus, multiple scheduler types, pluggable task drivers, and multi-region federation |
| [podman](../oss/podman/README.md) | Daemonless container management with multi-process architecture coordinating conmon, OCI runtimes, and network backends |
| [polars](../oss/polars/README.md) | Query engine with lazy evaluation, query optimizer, streaming execution, and Apache Arrow columnar processing |
| [pulsar](../oss/pulsar/README.md) | Distributed pub-sub with compute-storage separation, BookKeeper persistence, namespace multi-tenancy, and geo-replication |
| [qdrant](../oss/qdrant/README.md) | Distributed vector database with HNSW indexing, multi-quantization, Raft consensus, and shard management |
| [quarkus](../oss/quarkus/README.md) | Build-time optimized Java framework with augmentation pipeline, Arc CDI, and bytecode recording system |
| [rocksdb](../oss/rocksdb/README.md) | LSM-tree storage engine with complex compaction strategies, MVCC, multi-threaded background operations, and pluggable memtables |
| [rust-analyzer](../oss/rust-analyzer/README.md) | Incremental compiler infrastructure with Salsa query system, HIR layers, and IDE feature implementations |
| [swc](../oss/swc/README.md) | Multi-phase JavaScript/TypeScript compiler with lexer/parser/transform/codegen pipeline and WebAssembly plugin system |
| [terraform](../oss/terraform/README.md) | Infrastructure-as-code with DAG execution engine, gRPC provider plugin system, and state management with locking |
| [tikv](../oss/tikv/README.md) | Distributed transactional KV store with Multi-Raft consensus, Percolator 2PC, MVCC storage, and coprocessor push-down |
| [tokio](../oss/tokio/README.md) | Async runtime with work-stealing scheduler, reactor pattern I/O driver, hierarchical timer wheel, and task orchestration |
| [vault](../oss/vault/README.md) | Secrets management with encryption barrier, pluggable auth/secrets engines, expiration manager, and Raft storage |
| [wasmtime](../oss/wasmtime/README.md) | WebAssembly runtime with Cranelift JIT compiler, guard-page memory management, WASI implementation, and component model |
| [weaviate](../oss/weaviate/README.md) | Vector database with HNSW indexing, Raft consensus for schema, inverted indexes, and integrated ML model support |
| [zed](../oss/zed/README.md) | GPU-accelerated editor with custom GPUI framework, CRDT-based collaboration, and display-map rendering pipeline |

---

## Learning Paths

Themed sequences of projects that build on each other. Each path follows a progression from simpler foundational components to more complex systems that depend on or extend them.

### Container Ecosystem

containerd -> podman -> moby -> compose -> kubernetes -> helm

Follow the container stack from runtime to orchestration. Start with [containerd](../oss/containerd/README.md) to understand how containers actually run (shims, snapshots, CRI). Compare with [Podman](../oss/podman/README.md) for the daemonless, rootless-first alternative using conmon. Move to [moby](../oss/moby/README.md) to see how Docker wraps containerd with image building and networking. Then [compose](../oss/compose/README.md) shows multi-container application definition. [Kubernetes](../oss/kubernetes/README.md) introduces distributed orchestration on top of container runtimes. Finally, [helm](../oss/helm/README.md) adds package management for Kubernetes applications.

### Observability Stack

prometheus -> grafana -> loki -> opentelemetry-collector -> thanos

Build understanding of modern observability layer by layer. [Prometheus](../oss/prometheus/README.md) teaches metrics collection, TSDB internals, and PromQL. [Grafana](../oss/grafana/README.md) shows how to build a visualization platform with pluggable data sources. [Loki](../oss/loki/README.md) applies Prometheus-like label indexing to log aggregation. [OpenTelemetry Collector](../oss/opentelemetry-collector/README.md) demonstrates a vendor-neutral telemetry pipeline with receivers, processors, and exporters. [Thanos](../oss/thanos/README.md) extends Prometheus with long-term storage, global querying, and downsampling.

### Data Infrastructure

redis -> kafka -> spark -> flink -> arrow

Progress from single-node data storage to distributed streaming and analytics. [Redis](../oss/redis/README.md) covers in-memory data structures and event-driven I/O. [Kafka](../oss/kafka/README.md) introduces distributed commit logs and partition-based parallelism. [Spark](../oss/spark/README.md) shows batch and micro-batch processing with DAG execution and query optimization. [Flink](../oss/flink/README.md) adds true stream processing with exactly-once guarantees and watermark-based event time handling. [Arrow](../oss/arrow/README.md) provides the columnar memory format that enables zero-copy data exchange between all these systems.

### Web Development

react -> nextjs -> vite -> svelte

Explore different approaches to building web applications. [React](../oss/react/README.md) introduces the component model, virtual DOM, and concurrent rendering. [Next.js](../oss/nextjs/README.md) builds on React with server-side rendering, routing, and the App Router architecture. [Vite](../oss/vite/README.md) takes a different angle by focusing on build tooling with native ES modules and on-demand compilation. [Svelte](../oss/svelte/README.md) challenges the virtual DOM approach entirely with compile-time reactivity and zero-runtime overhead.

### Cloud-Native Networking

coredns -> envoy -> istio -> cilium -> linkerd2 -> consul

Trace the networking stack from DNS to service mesh. [CoreDNS](../oss/coredns/README.md) handles service discovery via plugin-chained DNS resolution. [Envoy](../oss/envoy/README.md) provides the programmable L4/L7 proxy with filter chains and xDS configuration. [Istio](../oss/istio/README.md) builds a control plane on top of Envoy for traffic management, security, and observability. [Cilium](../oss/cilium/README.md) uses eBPF for kernel-level networking, security, and observability without sidecar proxies. [Linkerd2](../oss/linkerd2/README.md) offers a lightweight alternative service mesh focused on simplicity and Rust-based micro-proxies. [Consul](../oss/consul/README.md) combines service discovery, health checking, and service mesh capabilities with Raft consensus and gossip protocol.

### Infrastructure as Code

terraform -> opentofu -> crossplane -> dagger -> flux2 -> argo-cd

Learn how modern tools manage infrastructure declaratively. [Terraform](../oss/terraform/README.md) introduces the foundational plan/apply workflow with DAG execution and gRPC provider plugins. [OpenTofu](../oss/opentofu/README.md) is the community fork adding state encryption while maintaining compatibility. [Crossplane](../oss/crossplane/README.md) brings infrastructure management into Kubernetes via custom resources and composition. [Dagger](../oss/dagger/README.md) applies containerized pipelines to CI/CD with a programmable API. [Flux2](../oss/flux2/README.md) implements GitOps for Kubernetes with source tracking, Kustomize, and Helm integration. [Argo CD](../oss/argo-cd/README.md) provides a full GitOps continuous delivery platform with application sync, health monitoring, and rollback.

### Security and Secrets

trivy -> falco -> vault -> keycloak

Learn how security is implemented at different layers. [Trivy](../oss/trivy/README.md) provides vulnerability scanning with modular analyzers for containers, filesystems, and code. [Falco](../oss/falco/README.md) monitors runtime security using kernel-level event capture via eBPF and a rule engine. [Vault](../oss/vault/README.md) manages secrets with an encryption barrier, pluggable auth/secrets engines, and Raft storage. [Keycloak](../oss/keycloak/README.md) handles identity and access management with multi-protocol support and SPI-driven extensibility.
