# Architecture Comparisons

This document compares the architectural design of similar open source projects analyzed in this repository. Rather than comparing feature checklists, each section focuses on the fundamental design philosophies, architectural trade-offs, and structural differences that shape how these systems behave under real-world conditions.

The goal is to help engineers understand not just _what_ each project does, but _why_ it is built the way it is, and when each approach is most appropriate.

---

## Message Brokers: Kafka vs Pulsar vs NATS

Three distributed messaging systems that take fundamentally different approaches to the balance between simplicity, scalability, and operational complexity.

### Design Philosophy

[Kafka](../oss/kafka/README.md) is built around the append-only commit log as its central abstraction. Everything flows from this single idea: topics are partitioned logs, replication is log forwarding, and consumers are simply log readers tracking offsets. Kafka leverages OS primitives (page cache, zero-copy sendfile) rather than building application-level caching, resulting in a system that is conceptually simple yet achieves extraordinary throughput. The recent migration from ZooKeeper to KRaft reflects a commitment to reducing external dependencies while maintaining the log-centric philosophy.

[Pulsar](../oss/pulsar/README.md) takes the opposite approach by explicitly separating compute from storage. Stateless brokers handle message serving while Apache BookKeeper provides durable, segment-based storage. This layered architecture was born at Yahoo! to serve millions of independent topics with multi-tenancy as a first-class concern. Pulsar's hierarchical namespace (tenant/namespace/topic) and segment-centric storage model (sequences of immutable ledgers) reflect a design optimized for large organizations running diverse workloads on shared infrastructure.

[NATS](../oss/nats-server/README.md) prioritizes radical simplicity. The entire system -- Core NATS messaging, JetStream persistence, Raft consensus, and multi-protocol support -- compiles into a single Go binary with zero external dependencies. NATS uses a text-based protocol parsed by a hand-written zero-allocation state machine, subject-based addressing with a trie data structure for routing, and interest-based message propagation that only forwards messages to servers with active subscribers. JetStream builds persistence as a layer on top of Core NATS, using NATS subjects for its own API and Raft communication.

### Key Architectural Differences

| Aspect | Kafka | Pulsar | NATS |
|---|---|---|---|
| Storage model | Partitioned append-only log, OS page cache | Segment-centric (BookKeeper ledgers), tiered storage | File-based block store or in-memory, per-stream |
| Compute-storage coupling | Tightly coupled (brokers own partitions) | Fully separated (stateless brokers + BookKeeper) | Embedded (single binary) |
| Replication | ISR (In-Sync Replica) set, pull-based | BookKeeper quorum writes, ensemble-based | Per-stream Raft groups |
| Consensus | KRaft (Raft for metadata only) | ZooKeeper/etcd for metadata, quorum for storage | Custom Raft per stream + meta-group |
| Consumer model | Pull-based with consumer groups | Push with flow control (FLOW permits) | Pull-based (JetStream), push (Core NATS) |
| Multi-tenancy | Limited (ACLs, quotas) | Native (tenant/namespace hierarchy, bundles) | Account-based with subject namespace isolation |
| Protocol | Custom binary protocol | Protocol Buffers over TCP (Netty) | Text-based with zero-allocation parser |
| External dependencies | None (KRaft mode) | BookKeeper + ZooKeeper/etcd | None |
| Primary language | Java/Scala | Java | Go |

### Trade-offs

Kafka's tight coupling of compute and storage means adding storage capacity requires adding brokers, but it eliminates the network hop between serving and storage layers. Pulsar's separation allows independent scaling but adds operational complexity (two distributed systems to manage) and an extra network hop. NATS eliminates all external dependencies at the cost of implementing everything in-process, but the result is remarkably simple to deploy and operate.

Kafka's ISR model provides configurable durability guarantees through the `acks` parameter, allowing users to choose their latency-durability trade-off point. Pulsar's BookKeeper quorum writes guarantee durability but with write amplification (3x by default). NATS's per-stream Raft provides strong consistency with independent failure isolation per stream, at the cost of more Raft groups to manage.

### When to Choose Each

- Kafka: Large-scale event streaming with high throughput requirements, event sourcing architectures, stream processing pipelines (Kafka Streams), and environments where the operations team can manage a cluster of brokers
- Pulsar: Multi-tenant environments requiring strict isolation, organizations needing geo-replication across data centers, workloads with diverse topic counts (millions of topics), and scenarios requiring tiered storage for cost optimization
- NATS: Edge computing, IoT, and microservice communication where operational simplicity is paramount; environments requiring both ephemeral messaging and persistent streaming from a single system; deployments where zero external dependencies and a single binary are valued

---

## Key-Value Stores: Redis vs etcd vs TiKV

Three key-value stores with radically different consistency models, scale targets, and use cases.

### Design Philosophy

[Redis](../oss/redis/README.md) is built on a single-threaded, event-driven architecture where one main thread handles all command execution, achieving sub-millisecond latency through the absence of locks, context switches, and cache contention. Redis implements its own event loop (the `ae` library, roughly 800 lines of code), uses fork-based copy-on-write snapshots for persistence, and employs multi-encoding data types where each logical type (hash, list, set, sorted set) uses compact internal representations for small collections that transparently upgrade to full data structures as they grow.

[etcd](../oss/etcd/README.md) prioritizes strong consistency through Raft consensus with linearizable reads. Its architecture follows strict layers: gRPC API, EtcdServer orchestrator, Raft consensus, and MVCC storage backed by bbolt (an embedded B+tree). The MVCC store assigns every write a monotonically increasing revision tuple, never overwriting keys in place. This append-only model naturally enables time-travel queries, efficient Watch (stream changes since revision N), and transactional multi-key atomicity. etcd's Raft library is deliberately minimalist -- it excludes networking, storage, and serialization, modeling consensus as a pure state machine.

[TiKV](../oss/tikv/README.md) is designed for horizontal scalability through Multi-Raft, where data is divided into Regions (default 96 MB each) that each form independent Raft groups. Built in Rust for memory safety without GC pauses, TiKV implements Percolator-style distributed transactions using three RocksDB Column Families (CF_DEFAULT for data, CF_LOCK for locks, CF_WRITE for commit records). The Placement Driver (PD) coordinates metadata, timestamp allocation, and data scheduling across nodes. TiKV's BatchSystem drives millions of FSMs on a fixed thread pool, processing multiple Raft groups per poll iteration.

### Key Architectural Differences

| Aspect | Redis | etcd | TiKV |
|---|---|---|---|
| Consistency model | Single-threaded (atomic per command), async replication | Linearizable via Raft quorum | Snapshot isolation via Percolator 2PC |
| Threading model | Single main thread + optional I/O threads | Multi-goroutine with Raft serialization | BatchSystem actor model (fixed thread pool) |
| Storage engine | In-memory with RDB/AOF persistence | bbolt (embedded B+tree, single writer) | RocksDB (LSM-tree, multi-CF) |
| Data model | Rich types (strings, hashes, lists, sets, sorted sets, streams) | Flat key-value with MVCC revisions | Raw key-value + transactional key-value |
| Scale target | Single node (cluster for sharding) | 3-5 node cluster, metadata-scale | Hundreds of nodes, petabyte-scale |
| Replication | Async primary-replica (PSYNC) | Raft consensus (quorum writes) | Multi-Raft (per-Region Raft groups) |
| Sharding | Hash-slot based (16,384 slots, CRC16) | No sharding (single Raft group) | Range-based (auto-split/merge Regions) |
| Transactions | MULTI/EXEC (optimistic locking) | Mini-transactions (If/Then/Else) | Distributed ACID (Percolator 2PC) |
| Primary language | C | Go | Rust |

### Trade-offs

Redis trades durability guarantees for extreme speed. Its single-threaded model eliminates concurrency overhead but cannot leverage multiple CPU cores for command execution. etcd provides the strongest consistency guarantees but is designed for metadata-scale workloads (typically under 8 GB of data) -- it is not a general-purpose database. TiKV achieves horizontal scalability with ACID transactions but at the cost of significantly higher operational complexity (TiKV nodes + Placement Driver + monitoring).

Redis's fork-based persistence leverages OS copy-on-write but can cause memory spikes (up to 2x) during snapshots. etcd's batched writes through `batchTx` amortize fsync costs but add complexity for read-your-writes consistency (solved via `txReadBuffer` overlay). TiKV's Multi-Raft manages millions of Regions but introduces metadata overhead and heartbeat traffic that grows linearly with Region count.

### When to Choose Each

- Redis: Caching layers, session stores, leaderboards, rate limiters, real-time pub/sub, and any workload where sub-millisecond latency matters more than strong consistency or data volumes exceed memory
- etcd: Kubernetes cluster state, distributed configuration, service discovery, leader election, and distributed locking -- workloads requiring strong consistency on a relatively small dataset
- TiKV: Large-scale transactional workloads (100+ TB), as the storage layer for distributed SQL databases (TiDB), and scenarios requiring both strong consistency and horizontal scalability with ACID transactions

---

## Service Mesh: Istio vs Linkerd2

Two service meshes with contrasting philosophies on complexity, performance, and feature scope.

### Design Philosophy

[Istio](../oss/istio/README.md) provides a comprehensive service mesh platform built on the battle-tested Envoy proxy. Its control plane (istiod) is a consolidated binary that handles service discovery, configuration management, certificate issuance, and xDS configuration distribution. Istio evolved from a microservices architecture (Pilot, Citadel, Galley, Mixer) to a monolithic binary, demonstrating that operational simplicity often outweighs architectural purity. The introduction of ambient mesh mode (ztunnel for L4 + optional waypoint proxies for L7) separates security concerns from application logic without per-pod sidecar overhead.

[Linkerd2](../oss/linkerd2/README.md) prioritizes simplicity and performance through a purpose-built Rust proxy (linkerd2-proxy) that achieves sub-millisecond p99 latency overhead and typically under 10 MB memory per proxy. The control plane is decomposed into discrete services (destination, identity, proxy-injector, policy-controller) with distinct failure domains. Linkerd emphasizes "secure by default" with automatic mTLS requiring zero configuration. Optional features (observability, multicluster, tracing) are distributed as separate extensions, maintaining a minimal core footprint.

### Key Architectural Differences

| Aspect | Istio | Linkerd2 |
|---|---|---|
| Data plane proxy | Envoy (C++, general-purpose) | linkerd2-proxy (Rust, purpose-built) |
| Proxy memory footprint | 50-100 MB per sidecar (typical) | Under 10 MB per sidecar (typical) |
| Control plane architecture | Monolithic binary (istiod) | Discrete services (destination, identity, proxy-injector, policy-controller) |
| Configuration distribution | xDS protocol (SotW + Delta) with debouncing | Custom gRPC streaming API (linkerd2-proxy-api) |
| Data plane modes | Sidecar + Ambient (ztunnel/waypoint) | Sidecar only |
| Traffic management | VirtualService, DestinationRule, Gateway API | ServiceProfile, HTTPRoute (Gateway API), TrafficSplit |
| Load balancing | Round-robin, least connections, ring hash, random | EWMA (Exponentially Weighted Moving Average) latency-aware |
| Policy engine | CEL expressions, RBAC, JWT validation | Server, ServerAuthorization, AuthorizationPolicy CRDs (Rust controller) |
| Extensibility | Envoy filters, WASM plugins, EnvoyFilter CRD | Extension-based architecture (viz, multicluster, jaeger) |
| Identity framework | SPIFFE (via Envoy SDS) | SPIFFE (via CSR to identity service) |
| Multi-cluster | Native gateway-based with shared control plane | Service mirroring with gateway |

### Trade-offs

Istio's use of Envoy provides a rich feature set (advanced traffic management, WASM extensibility, protocol-level observability) but at the cost of higher per-pod resource consumption and configuration complexity. The Envoy configuration model is powerful but requires a sophisticated translation layer (the networking core) to bridge Istio's user-facing APIs to Envoy's native format. Ambient mode addresses the resource concern by sharing proxies at the node and namespace level, but introduces new infrastructure components (ztunnel, waypoint proxies) and the HBONE tunneling protocol.

Linkerd2's purpose-built Rust proxy achieves 10x lower memory footprint and latency by excluding features irrelevant to sidecar scenarios (edge gateway capabilities, complex routing DSL). This minimalism is a strength for resource-constrained environments but means fewer extension points compared to Envoy. The discrete control plane services provide better fault isolation (a bug in proxy injection does not impact service discovery) but increase operational surface area.

### When to Choose Each

- Istio: Organizations needing rich traffic management (canary deployments, traffic mirroring, fault injection), WASM-based extensibility, multi-cluster mesh federation, or environments already invested in the Envoy ecosystem; teams willing to accept higher resource overhead for more features
- Linkerd2: Organizations prioritizing operational simplicity, minimal resource overhead, and the fastest path to zero-trust networking; environments where sub-millisecond added latency matters; teams that prefer a "just works" approach with sensible defaults over extensive configurability

---

## Container Runtimes: containerd vs Podman vs Moby

Three container management systems occupying different layers of the container ecosystem.

### Design Philosophy

[containerd](../oss/containerd/README.md) follows a smart-client/thin-daemon architecture that deliberately exposes low-level primitives (content blobs, snapshots, mount structs, task handles) instead of high-level abstractions. Every subsystem is a plugin with typed dependencies, and the shim process model (runtime v2) provides crash isolation -- containerd can restart without killing running containers because each container's lifecycle is managed by a dedicated shim process communicating over ttrpc. containerd's scope is explicitly defined in SCOPE.md, requiring 100% maintainer vote to change.

[Podman](../oss/podman/README.md) takes a fundamentally different approach: daemonless architecture with a per-container conmon process that double-forks and independently monitors each container. The podman CLI can exit after launching a container, and state is tracked in SQLite. Podman was designed rootless-first, using user namespaces, slirp4netns/pasta for networking, and per-user storage. The same codebase supports both local (ABI) and remote (Tunnel) modes through Go build tags and a shared domain entity layer.

[Moby](../oss/moby/README.md) (Docker Engine) sits at the highest level, providing the developer experience layer including the Docker API, image build pipeline (via BuildKit), networking (via libnetwork with CNM model), and Swarm orchestration. Moby delegates all container runtime operations to containerd via gRPC, making containerd its foundation. The architecture centers on the `dockerd` daemon with a versioned REST API, middleware chain, and backend interface segregation for testability.

### Key Architectural Differences

| Aspect | containerd | Podman | Moby (Docker Engine) |
|---|---|---|---|
| Process model | Long-running daemon + per-container shims | Daemonless (CLI + per-container conmon) | Long-running daemon (dockerd) delegating to containerd |
| Container supervision | Shim process (ttrpc communication) | conmon process (double-fork, daemonized) | containerd shim (via containerd delegation) |
| Daemon restart resilience | Containers survive daemon restart (shim holds state) | Containers survive (conmon persists independently) | Containers survive (containerd manages shims) |
| State storage | BoltDB (single file, namespaced) | SQLite (ACID, concurrent access) | containerd's BoltDB + Docker's internal state |
| Rootless support | Supported (via rootless kit) | First-class, designed from ground up | Supported (rootless dockerd mode) |
| Image building | Not in scope (delegated to BuildKit/clients) | Buildah integration | BuildKit integration (default since 23.0) |
| Networking | Not in scope (CNI via CRI plugin) | Netavark + Aardvark-DNS | libnetwork (Container Network Model) |
| Orchestration | Not in scope | Not in scope (relies on Kubernetes/systemd) | Built-in Swarm mode (SwarmKit) |
| API surface | gRPC (low-level primitives) | REST API (Docker-compatible + native) | REST API (versioned, Docker standard) |
| Multi-tenancy | Namespace-based (content shared across namespaces) | Per-user isolation (rootless storage) | Single-tenant (one user of containerd) |
| Plugin system | Type-based plugins with dependency graph | OCI runtime interface abstraction | Driver/plugin model (network, volume, storage) |
| Primary consumers | Docker Engine, Kubernetes, nerdctl, BuildKit | Direct users, systemd, Kubernetes (via CRI-O) | Docker CLI, Docker Compose |

### Trade-offs

containerd's thin-daemon approach pushes complexity to clients (Docker, nerdctl, Kubernetes kubelet) but keeps the daemon auditable and stable. This means different clients may implement the same high-level operations differently. Podman's daemonless design eliminates the single point of failure and idle resource consumption but requires SQLite-based state synchronization between concurrent CLI invocations and relies on systemd units (Quadlet) for automatic restart management. Moby provides the richest developer experience with networking, volumes, build, and orchestration all integrated, but at the cost of a larger attack surface and dependency on the dockerd daemon.

containerd's plugin system (where every subsystem is a plugin) provides remarkable extensibility, including proxy plugins that communicate via gRPC sockets for external implementations. Podman's OCI runtime interface abstracts the actual runtime (crun, runc, kata, gVisor) but the interface is large (25+ methods). Moby's delegation to containerd and BuildKit enables independent evolution of each layer but adds operational complexity (multiple daemons).

### When to Choose Each

- containerd: As a container runtime for Kubernetes (via CRI), as the foundation for custom container platforms, or when you need a minimal, stable runtime with a well-defined scope
- Podman: Security-sensitive environments where running a privileged daemon is undesirable, systemd-managed deployments, rootless container workloads, and Docker-compatible workflows without the daemon overhead
- Moby (Docker Engine): Developer workstations, Docker Compose workflows, environments requiring built-in networking/volumes/build/Swarm, and ecosystems already built around the Docker API

---

## Frontend Frameworks: React vs Svelte vs SolidJS

Three UI frameworks with fundamentally different approaches to reactivity, rendering, and the compile-time vs runtime spectrum.

### Design Philosophy

[React](../oss/react/README.md) pioneered the declarative, component-based UI model with Virtual DOM diffing. The Fiber architecture reimplements the reconciliation algorithm as a linked list of virtual stack frames, enabling incremental rendering with priority-based scheduling. React maintains two Fiber trees (current and work-in-progress) using double buffering for atomic updates. The reconciler/renderer separation through the host config pattern enables React to target multiple platforms (DOM, Native, Canvas) from a single core. React Compiler automates memoization at build time, and React Server Components enable zero-bundle server-only components that stream to the client.

[Svelte](../oss/svelte/README.md) shifts the majority of work from runtime to compile time through a three-phase compiler pipeline (parse, analyze, transform). Svelte 5 introduced runes ($state, $derived, $effect) -- compiler primitives that map to a signals-based, fine-grained reactivity system with Proxy-based deep observation. The compiler generates specific code for each component's exact needs: a component without transitions does not include transition code. This per-component tree-shaking is only possible through compilation, resulting in smaller bundles and faster execution than runtime-framework approaches.

[SolidJS](../oss/solid/README.md) combines React-like JSX syntax with fine-grained reactivity that eliminates the Virtual DOM entirely. Components are regular JavaScript functions that run once to set up the view; only the code that depends on changed state reruns. The reactive signal system uses a push-pull hybrid model with synchronous updates and automatic dependency tracking through a global Listener variable. The Babel compiler extracts static HTML into template strings (cloned via `_$template()`) and wraps dynamic expressions in effects that subscribe to reactive dependencies.

### Key Architectural Differences

| Aspect | React | Svelte | SolidJS |
|---|---|---|---|
| Rendering strategy | Virtual DOM diffing (Fiber reconciler) | Compiled DOM manipulation (no virtual DOM) | Direct DOM updates via fine-grained reactivity |
| Reactivity model | Component-level re-rendering with hooks | Signals-based ($state, $derived, $effect via runes) | Signals-based (createSignal, createMemo, createEffect) |
| Update granularity | Component-level (re-runs entire component function) | Property-level (Proxy-based tracking) | Signal-level (only dependent computations re-run) |
| Compile-time work | JSX transform + optional React Compiler (memoization) | Full compiler pipeline (parse, analyze, transform) | JSX transform with template extraction |
| Runtime size | ~42 KB (react) + ~130 KB (react-dom) minified | Minimal (scales with component features used) | ~7 KB (solid-js) minified |
| Component execution | Re-runs on every state change | Setup runs once, reactivity handles updates | Runs once, effects handle updates |
| State management | useState/useReducer (hooks), external stores | $state rune (Proxy-wrapped signals) | createSignal (getter/setter pair), createStore (Proxy) |
| Deep reactivity | Requires immutable updates or external library | Built-in via Proxy ($state on objects/arrays) | Built-in via Proxy (createStore) |
| Server rendering | React Server Components (streaming, selective hydration) | SSR via server runtime (string concatenation) | SSR with streaming and progressive hydration |
| Scheduling | Priority-based scheduler (lanes), concurrent rendering | Synchronous batched updates | Synchronous with batch() for explicit batching |
| Platform targets | DOM, Native, Canvas, VR, custom renderers | DOM (web only) | DOM, custom renderers (via separate packages) |
| Memoization | Manual (useMemo, useCallback, memo) or automatic (Compiler) | Automatic ($derived is lazy, compiler optimizes) | Automatic (createMemo, fine-grained tracking) |

### Trade-offs

React's Virtual DOM adds overhead for diffing but provides a universal abstraction that works across platforms and enables features like concurrent rendering, Suspense, and error boundaries through the two-phase render/commit split. The Fiber architecture's complexity is the price of interruptible, prioritized rendering. React Compiler addresses the manual memoization burden but requires valid "Rules of React" code.

Svelte's compiler approach eliminates runtime framework overhead and generates minimal, specific code per component. The trade-off is a required build step, less dynamic runtime introspection, and debugging compiled code that differs from source. Svelte 5's shift to runes was a major breaking change but provides more predictable reactivity that works outside component boundaries.

SolidJS achieves near-native performance (consistently top-ranked in JS Framework Benchmark) by eliminating the VDOM and running components exactly once. The trade-off is that reactivity requires explicit primitives (signals, memos, effects) and JSX expressions must be wrapped in functions to maintain reactivity. Runtime template generation is limited compared to React's createElement flexibility.

### When to Choose Each

- React: Large teams and long-lived applications where ecosystem breadth matters (libraries, tooling, hiring), cross-platform development (React Native), applications requiring concurrent rendering features (Suspense, transitions), and server-component architectures for data-heavy applications
- Svelte: Projects prioritizing small bundle size and runtime performance, teams that value concise component syntax, applications where the compile step is acceptable, and use cases benefiting from SvelteKit's full-stack framework
- SolidJS: Performance-critical applications where every millisecond of rendering time matters, teams comfortable with fine-grained reactivity semantics, projects where minimal bundle size is essential, and developers who want React-like DX without the VDOM overhead

---

## Infrastructure as Code: Terraform vs OpenTofu vs Crossplane

Three approaches to declarative infrastructure management with different execution models, extensibility patterns, and governance philosophies.

### Design Philosophy

[Terraform](../oss/terraform/README.md) is built around a pipeline architecture centered on a DAG (Directed Acyclic Graph) engine. User commands flow through CLI, backend, configuration parsing, graph building, and parallel graph walking. Providers run as separate OS processes communicating via gRPC (protocol v5/v6), completely decoupling core from the 3,000+ provider ecosystem. The explicit plan-then-apply two-phase workflow gives operators a serializable preview of all changes before any mutations occur. HCL (a custom DSL) constrains expressiveness to make configurations deterministic and plannable.

[OpenTofu](../oss/opentofu/README.md) is a community fork of Terraform (post-BSL license change) under the Linux Foundation, maintaining CLI compatibility while adding differentiating features. The architecture is structurally identical to Terraform -- DAG-based execution with graph transformers, gRPC provider plugins, and the same HCL configuration language. Key additions include native state encryption with pluggable key providers and encryption methods, early variable evaluation in the terraform block, and open governance with a Technical Steering Committee.

[Crossplane](../oss/crossplane/README.md) takes a fundamentally different approach by extending Kubernetes itself as the control plane. Instead of a standalone CLI tool, Crossplane uses Custom Resource Definitions (CRDs) and controllers to provide a declarative API. Platform teams define CompositeResourceDefinitions (XRDs) and Compositions to build higher-level abstractions. A dynamic Controller Engine creates controllers at runtime based on installed XRDs. Composition Functions execute as gRPC services in a pipeline, enabling extensible transformation logic without modifying Crossplane core. Providers, Functions, and Configurations are distributed as OCI images.

### Key Architectural Differences

| Aspect | Terraform | OpenTofu | Crossplane |
|---|---|---|---|
| Execution model | CLI-driven plan/apply pipeline | CLI-driven plan/apply pipeline (compatible) | Kubernetes reconciliation loop (continuous) |
| Configuration language | HCL (declarative DSL) | HCL (compatible) | Kubernetes YAML/CRDs |
| State management | State file (JSON) with backend abstraction | State file with native encryption | Kubernetes etcd (live state in API server) |
| Provider architecture | Separate processes via gRPC (go-plugin) | Separate processes via gRPC (go-plugin) | Separate pods running Kubernetes controllers |
| Graph execution | DAG with parallel walker (goroutine per vertex) | DAG with parallel walker (compatible) | Kubernetes controller reconciliation per resource |
| Drift detection | On plan/apply (periodic) | On plan/apply (periodic) | Continuous (controller reconciliation loop) |
| Extensibility | Providers (gRPC) + modules (HCL) | Providers (gRPC) + modules (HCL) | Providers (OCI) + Composition Functions (gRPC) + XRDs |
| Composition model | Modules with input/output variables | Modules with input/output variables | Compositions with function pipelines |
| Update safety | Plan preview before apply | Plan preview before apply | Composition Revisions (immutable, controlled rollout) |
| License | BSL 1.1 (Business Source License) | MPL 2.0 (open source) | Apache 2.0 |
| Governance | HashiCorp (single vendor) | Linux Foundation (community TSC) | CNCF (community) |

### Trade-offs

Terraform/OpenTofu's CLI-driven model provides explicit control over when changes are applied, making it well-suited for infrastructure that changes infrequently and benefits from human review. The DAG walker enables parallel execution of independent resources, but the graph must be rebuilt for each operation. The state file is both a strength (provides a clear mapping between config and reality) and a liability (can become stale, contains sensitive data, requires locking).

OpenTofu adds state encryption as a first-class feature with pluggable key providers (static, AWS KMS) and fallback support for key rollover, addressing one of Terraform's most requested features. The architecture is otherwise identical, ensuring compatibility with existing Terraform workflows, providers, and modules.

Crossplane's Kubernetes-native approach provides continuous reconciliation (drift is automatically corrected), but at the cost of requiring a Kubernetes cluster as the control plane. The dynamic Controller Engine can scale to hundreds of custom resource types without restarts, and Composition Functions solve the "configuration DSL problem" by delegating complex logic to external, testable gRPC services. However, the operational model is fundamentally different from CLI-driven IaC -- there is no equivalent of `terraform plan` as a discrete step. Composition Revisions provide update safety through immutable versioning.

### When to Choose Each

- Terraform: Organizations that prefer a standalone CLI tool with explicit plan/apply workflow, environments where HashiCorp's commercial offerings (Terraform Cloud/Enterprise) are valued, and teams already invested in the Terraform ecosystem
- OpenTofu: Organizations that require open-source licensing (MPL 2.0), teams needing native state encryption, environments where vendor-neutral governance matters, and existing Terraform users seeking a drop-in replacement with community-driven development
- Crossplane: Platform teams building internal developer platforms on Kubernetes, organizations wanting continuous reconciliation (GitOps-style), multi-cloud environments where Kubernetes is already the orchestration layer, and teams that prefer defining infrastructure as Kubernetes resources rather than HCL configurations
