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

---

## Learning Paths

Themed sequences of projects that build on each other. Each path follows a progression from simpler foundational components to more complex systems that depend on or extend them.

### Container Ecosystem

containerd -> moby -> compose -> kubernetes -> helm

Follow the container stack from runtime to orchestration. Start with [containerd](../oss/containerd/README.md) to understand how containers actually run (shims, snapshots, CRI). Move to [moby](../oss/moby/README.md) to see how Docker wraps containerd with image building and networking. Then [compose](../oss/compose/README.md) shows multi-container application definition. [Kubernetes](../oss/kubernetes/README.md) introduces distributed orchestration on top of container runtimes. Finally, [helm](../oss/helm/README.md) adds package management for Kubernetes applications.

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

coredns -> envoy -> istio -> cilium -> linkerd2

Trace the networking stack from DNS to service mesh. [CoreDNS](../oss/coredns/README.md) handles service discovery via plugin-chained DNS resolution. [Envoy](../oss/envoy/README.md) provides the programmable L4/L7 proxy with filter chains and xDS configuration. [Istio](../oss/istio/README.md) builds a control plane on top of Envoy for traffic management, security, and observability. [Cilium](../oss/cilium/README.md) uses eBPF for kernel-level networking, security, and observability without sidecar proxies. [Linkerd2](../oss/linkerd2/README.md) offers a lightweight alternative service mesh focused on simplicity and Rust-based micro-proxies.

### Infrastructure as Code

opentofu -> crossplane -> dagger -> flux2 -> argo-cd

Learn how modern tools manage infrastructure declaratively. [OpenTofu](../oss/opentofu/README.md) provides HCL-based infrastructure provisioning with provider plugins and state management. [Crossplane](../oss/crossplane/README.md) brings infrastructure management into Kubernetes via custom resources and composition. [Dagger](../oss/dagger/README.md) applies containerized pipelines to CI/CD with a programmable API. [Flux2](../oss/flux2/README.md) implements GitOps for Kubernetes with source tracking, Kustomize, and Helm integration. [Argo CD](../oss/argo-cd/README.md) provides a full GitOps continuous delivery platform with application sync, health monitoring, and rollback.
