# Design Patterns Across Projects

This document provides a cross-cutting reference of recurring design patterns found across the OSS architecture reports in this repository. Each pattern appears in multiple projects, often adapted to different domains — from databases to container runtimes to web frameworks. Studying how the same fundamental pattern manifests in different contexts reveals both its versatility and the trade-offs each project makes.

## Plugin / Extension Architecture

A system defines extension points through well-known interfaces, allowing new functionality to be added without modifying core code. Plugins are typically registered at compile time or startup and are invoked by the core framework at designated hook points.

| Project | Implementation Details |
|---|---|
| [Kubernetes](../oss/kubernetes/README.md) | Defines CRI (Container Runtime Interface), CNI (Container Network Interface), and CSI (Container Storage Interface) as gRPC-based plugin contracts. The kubelet delegates container lifecycle, networking, and storage operations to external implementations through these interfaces. Admission controllers form another extension axis, intercepting API requests via webhook chains. |
| [Envoy](../oss/envoy/README.md) | Employs a multi-layered filter chain architecture with Listener Filters, Network Filters (L4), and HTTP Filters (L7). Each filter implements a factory interface and is instantiated per-connection or per-request. The filter chain is the primary mechanism for all protocol handling — even core features like the HTTP connection manager are implemented as network filters. |
| [Caddy](../oss/caddy/README.md) | Uses a module registry pattern where plugins register themselves via `caddy.RegisterModule()` in Go `init()` functions. Modules implement lifecycle hooks (`Provision`, `Validate`, `Cleanup`) and are compiled statically into the binary. The `xcaddy` tool enables custom builds with arbitrary module combinations. |
| [CoreDNS](../oss/coredns/README.md) | Plugins are compiled in a fixed order defined by `plugin.cfg` and form a chain of responsibility for DNS query handling. Each plugin implements the `Handler` interface, returning an rcode and error. The ordering file is the single source of truth for plugin priority. |
| [containerd](../oss/containerd/README.md) | Adopts a "plugin-all-the-things" philosophy where virtually every subsystem (content store, snapshotter, runtime, diff, GC) is a plugin. Plugins declare their types and dependencies, and the daemon resolves the dependency graph at startup. External plugins communicate via gRPC over Unix sockets. |
| [Trivy](../oss/trivy/README.md) | Implements an Analyzer plugin architecture where each language/OS package detector is an independent Analyzer triggered by file pattern matching. With 60+ supported ecosystems, Analyzers are independently developable and testable. Post-Analyzers handle cases where results depend on other Analyzers' output. |
| [Bevy](../oss/bevy/README.md) | Plugins are the fundamental unit of composition. Every feature — rendering, audio, input, windowing — is a plugin that registers systems, resources, and components. Users compose their application by selecting which plugins to include, with fine-grained control via Cargo feature flags. |
| [Prometheus](../oss/prometheus/README.md) | Service discovery is implemented as a pluggable system where each discovery mechanism (Kubernetes, Consul, EC2, file-based, etc.) implements the `Discoverer` interface. New target discovery backends can be added without modifying the core scrape engine. |
| [Airflow](../oss/airflow/README.md) | The Provider architecture decouples integration code from core Airflow, with 80+ provider packages distributed independently. Each provider registers via entry points, exposing operators, hooks, sensors, and connection types. Providers can extend the CLI, add custom UI fields, and register secret backends or logging handlers without modifying core code. |
| [Backstage](../oss/backstage/README.md) | Backend plugins communicate only over HTTP/gRPC, enforcing isolation and independent deployment. Frontend plugins extend the app via the extension tree pattern, attaching to parent extension points. Each plugin receives isolated database connections and service instances, preventing cross-plugin coupling. |
| [Buf](../oss/buf/README.md) | Supports three plugin tiers: built-in plugins (compiled-in, zero-setup), remote plugins (Wasm from BSR, shareable), and custom plugins (binary, flexible). Plugins extend linting and breaking change detection via the bufplugin/check interface. The pluggable components system allows out-of-process gRPC components in any language. |
| [Dapr](../oss/dapr/README.md) | Component loaders register factory functions for state stores, pub/sub brokers, bindings, and secret stores via blank imports. The pluggable components system extends this with out-of-process gRPC plugins, enabling custom implementations in any language. Each component implements standardized interfaces for swappability across infrastructure providers. |
| [Deno](../oss/deno/README.md) | The extension system (`ext/`) provides 28+ extension crates for web APIs, networking, filesystem, and Node.js compatibility. Each extension registers ops (Rust functions exposed to JavaScript) and JavaScript glue code via the `extension!` macro. Extensions compose into a runtime snapshot pre-initialized at build time. |
| [DuckDB](../oss/duckdb/README.md) | The extension system supports dynamically loadable extensions for file formats (Parquet, JSON), cloud storage (S3, Azure), and specialized functions. Extensions can be developed independently and distributed separately, keeping the core database lightweight while enabling rich functionality on demand. |
| [Falco](../oss/falco/README.md) | The plugin framework (in libsinsp) allows extending Falco beyond syscalls with external event sources and field extractors. Plugins implement a C API for compatibility with any language, loaded dynamically at runtime. The system separates built-in plugins from community-contributed plugins while maintaining a consistent interface. |

## Pipeline / Dataflow Architecture

Processing is organized as a sequence of stages where data flows through a directed graph of transformations. Each stage has a well-defined input/output contract, enabling independent development, testing, and optimization of individual stages.

| Project | Implementation Details |
|---|---|
| [OpenTelemetry Collector](../oss/opentelemetry-collector/README.md) | Defines a three-stage pipeline: Receivers (ingest telemetry data) → Processors (transform/filter/batch) → Exporters (send to backends). Components are wired together via the `consumer` chain pattern. Connectors act as bridges between pipelines, serving as both exporter and receiver to enable fan-out and signal translation. |
| [Trivy](../oss/trivy/README.md) | Scans flow through a three-layer pipeline: Artifact analysis (image/filesystem parsing) → Scanner detection (vulnerability, misconfiguration, secret, license) → Report formatting (JSON, SARIF, Table, SBOM). The `artifact.Run()` orchestrator controls the entire flow using a Template Method pattern. |
| [Flink](../oss/flink/README.md) | User-defined operators are compiled into a streaming dataflow DAG. The JobManager translates the logical plan into an ExecutionGraph with parallel subtasks. Operator chaining fuses compatible operators into a single task to avoid serialization overhead. |
| [Spark](../oss/spark/README.md) | The Catalyst optimizer transforms logical plans through rule-based and cost-based optimization phases, ultimately producing a physical plan. The DAGScheduler breaks the physical plan into stages at shuffle boundaries, and the TaskScheduler distributes individual tasks to executors. Tungsten's whole-stage code generation fuses operators into single JVM methods. |
| [Envoy](../oss/envoy/README.md) | Request processing flows through a layered filter pipeline: Listener Filters → Network Filters → HTTP Filters. Each layer can inspect, modify, or terminate the request. The pipeline is configured dynamically via xDS APIs without restart. |
| [CockroachDB](../oss/cockroachdb/README.md) | Query processing flows through five architectural layers: SQL (parsing/planning/optimization) → Transaction (MVCC read/write) → Distribution (range routing via DistSender) → Replication (Raft consensus per range) → Storage (Pebble LSM engine). Each layer has clean interfaces enabling independent evolution. |
| [Airflow](../oss/airflow/README.md) | DAG execution flows through Scheduler (parse DAGs, create TaskInstances) → Executor (route tasks to workers) → Worker (execute Operator logic) with state transitions tracked in the metadata database. The pipeline supports pluggable executors (LocalExecutor, CeleryExecutor, KubernetesExecutor) for different scaling strategies. |
| [DuckDB](../oss/duckdb/README.md) | Query execution follows a pipeline model: Parser → Binder → Logical Planner → Optimizer → Physical Planner → Pipeline Executor. Operators within pipelines stream DataChunks without materialization until pipeline breakers (hash joins, aggregations), minimizing memory usage and enabling parallelism. |

## Event-Driven / Reactor Pattern

A single-threaded (or per-thread) event loop multiplexes I/O readiness notifications and dispatches events to handlers. This pattern avoids the overhead and complexity of thread-per-connection models while achieving high throughput for I/O-bound workloads.

| Project | Implementation Details |
|---|---|
| [Redis](../oss/redis/README.md) | Built around the `ae` (A simple Event library) — a custom, minimal event loop abstraction over epoll/kqueue/select. A single thread handles all client connections, command parsing, and execution. This design eliminates lock contention entirely, trading vertical scalability for simplicity and predictable latency. Background threads handle only lazy-free operations and I/O threading for read/write. |
| [Envoy](../oss/envoy/README.md) | Each worker thread runs its own event loop based on libevent. Connections are pinned to a single worker for their lifetime, creating a shared-nothing threading model. The main thread handles management tasks (xDS updates, stats flushing) on its own event loop, communicating with workers through TLS (Thread Local Storage) slot updates. |
| [Tokio](../oss/tokio/README.md) | The I/O driver wraps `mio` (a cross-platform I/O event notification library) to provide readiness-based async I/O. When a future polls for I/O readiness and the resource is not ready, the driver registers interest with the OS and parks the task. When the OS signals readiness, the driver wakes the corresponding task for re-polling. |
| [Kafka](../oss/kafka/README.md) | The `SocketServer` implements the Reactor pattern with an Acceptor thread that distributes new connections across a pool of Processor threads. Each Processor uses Java NIO selectors to multiplex many connections, forwarding parsed requests to the `KafkaRequestHandlerPool` for business logic execution. |
| [Alacritty](../oss/alacritty/README.md) | The Processor implements winit's ApplicationHandler trait, receiving window events on the main thread and dispatching to handlers. The PTY event loop runs on a dedicated thread, continuously polling the PTY file descriptor and feeding raw bytes to the VTE parser. The FairMutex prevents the PTY thread from starving the UI thread. |
| [Bun](../oss/bun/README.md) | Implements a custom event loop abstracting over io_uring (Linux) and kqueue (macOS/BSD) for async I/O. The event loop batches operations to amortize system call overhead, with io_uring performing reads/writes directly into user-provided buffers. Integrates with JavaScriptCore's microtask queue for Promise resolution ordering. |
| [Deno](../oss/deno/README.md) | The deno_core runtime integrates V8 with Tokio's async event loop. Async ops return Rust Futures mapped onto JavaScript Promises, with Tokio driving the event loop. The ops system bridges JavaScript and Rust using V8 fast-call bindings for minimal crossing overhead. |

## Write-Ahead Log (WAL)

Before applying a mutation to the main data structure, the operation is first durably written to a sequential append-only log. This ensures crash recovery — on restart, the system replays uncommitted log entries to restore consistent state. WAL decouples durability from indexing performance.

| Project | Implementation Details |
|---|---|
| [etcd](../oss/etcd/README.md) | Every Raft proposal is persisted to the WAL before being applied to the bbolt B+tree backend. WAL entries are organized in 64MB segment files with CRC checksums. On recovery, entries are replayed from the last snapshot forward. The WAL package is intentionally kept simple and self-contained within the etcd codebase. |
| [RocksDB](../oss/rocksdb/README.md) | All writes go to the WAL before being inserted into the active MemTable. The WAL ensures durability across process crashes. WAL files are recycled after the corresponding MemTable is flushed to an SST file. Options exist to disable WAL for performance-critical workloads that can tolerate data loss. |
| [Prometheus](../oss/prometheus/README.md) | The TSDB writes incoming samples to a WAL in the current "head" block before they are indexed in memory. During crash recovery, the WAL is replayed to reconstruct the in-memory index and chunk data. WAL segments are truncated as data is compacted into persistent blocks. |
| [Kafka](../oss/kafka/README.md) | The commit log itself is Kafka's primary data structure — an append-only, segmented log partitioned across brokers. Each partition's log is the WAL, with messages durably written before acknowledgment (depending on `acks` configuration). Log segments are rolled and cleaned based on retention policies. |
| [Redis](../oss/redis/README.md) | The AOF (Append Only File) persistence mode logs every write command before execution. Redis offers three fsync policies: `always`, `everysec`, and `no`. The AOF can be rewritten in the background using fork-based COW to compact it without blocking the main thread. |
| [TiKV](../oss/tikv/README.md) | Each Raft group maintains its own WAL via the underlying RocksDB instance (using a dedicated "raft" Column Family). Raft log entries are persisted before being applied to the state machine. The Raft engine handles log entry management, including truncation after snapshot application. |
| [Cortex](../oss/cortex/README.md) | Ingesters write all incoming samples to a WAL on persistent disk before acknowledging success. This provides durability against ingester crashes without relying solely on replication. WAL replay on startup recovers in-memory state, preventing data loss during rolling restarts or unexpected failures. |
| [Dgraph](../oss/dgraph/README.md) | Raft log entries are stored in a separate BadgerDB instance managed by the raftwal package, providing Raft's required Storage interface. The WAL separates Raft metadata from user data, preventing Raft log growth from affecting query performance. WAL files persist every Raft proposal before it's applied to the state machine. |
| [DuckDB](../oss/duckdb/README.md) | The WAL ensures durability for persistent databases by logging transactions before applying them to storage. During crash recovery, the WAL is replayed to restore the database to a consistent state. Checkpoints periodically snapshot the database, allowing WAL truncation. |
| [Go-Ethereum](../oss/go-ethereum/README.md) | The path-based trie storage scheme uses a diff layer buffer as an in-memory WAL, accumulating state changes before committing to disk. This approach provides durability while batching writes for performance. The legacy hash-based scheme also employs WAL semantics for state transitions. |

## LSM-Tree / Log-Structured Storage

Data is first written to an in-memory buffer (MemTable), then flushed to immutable sorted files on disk (SSTables/SST files). Background compaction merges overlapping files to bound read amplification. This design optimizes for write-heavy workloads at the cost of read amplification.

| Project | Implementation Details |
|---|---|
| [RocksDB](../oss/rocksdb/README.md) | The canonical LSM-tree implementation. Writes go to an active MemTable (skiplist by default, pluggable via `MemTableRep`), which is flushed to Level-0 SST files. Background compaction merges files across levels using leveled, universal, or FIFO strategies. Block cache with LRU eviction and Bloom filters reduce read amplification. Column Families provide logical separation with independent LSM trees sharing a single WAL. |
| [TiKV](../oss/tikv/README.md) | Uses RocksDB as its storage engine with three Column Families: `CF_DEFAULT` (values), `CF_LOCK` (transaction locks), and `CF_WRITE` (commit records). The `engine_traits` abstraction layer allows potential engine replacement. Each Raft region maps to a key range within the RocksDB instance. |
| [CockroachDB](../oss/cockroachdb/README.md) | Developed Pebble as a RocksDB-compatible LSM engine written in Go. Pebble implements leveled compaction, block-based SST format, and bloom filters. The decision to build a custom engine (rather than using RocksDB via CGo) was driven by the need to eliminate CGo overhead, enable Go-native memory management, and allow CockroachDB-specific optimizations. |
| [Prometheus](../oss/prometheus/README.md) | The TSDB uses a block-based architecture conceptually similar to LSM. The "head" block holds recent data in memory, periodically compacted into immutable 2-hour blocks on disk. Background compaction merges older blocks, trading write amplification for query efficiency. The design is optimized for time-series access patterns with high write throughput and range queries. |
| [Dgraph](../oss/dgraph/README.md) | Built BadgerDB as a pure Go LSM-tree database optimized for graph workloads. BadgerDB separates values from the LSM tree (value log design), reducing write amplification for large posting lists. MVCC is native to BadgerDB, with each posting list storing multiple versions. The decision to build BadgerDB avoided CGo overhead and enabled graph-specific optimizations. |

## Raft Consensus Protocol

A leader-based consensus algorithm that ensures a replicated log is consistently applied across a cluster of nodes. One node is elected leader and replicates log entries to followers; entries are committed once a quorum acknowledges them. Raft provides linearizable reads and tolerates up to (N-1)/2 node failures in an N-node cluster.

| Project | Implementation Details |
|---|---|
| [etcd](../oss/etcd/README.md) | Contains a standalone, minimal Raft library (`raft/`) that is intentionally not networked — it is a pure state machine that takes messages in and produces messages out. The embedding application (etcd server) is responsible for network transport and storage. This design makes the Raft implementation highly testable and reusable. |
| [TiKV](../oss/tikv/README.md) | Implements Multi-Raft, where the key space is divided into Regions and each Region runs an independent Raft group. This enables horizontal scalability — adding nodes redistributes regions. The PD (Placement Driver) component handles region scheduling, leader balancing, and split/merge operations across the cluster. |
| [CockroachDB](../oss/cockroachdb/README.md) | Also implements Multi-Raft at the Replication layer. Each Range (64MB by default) is a Raft group with typically 3 or 5 replicas. Range leases provide a mechanism for consistent reads without going through Raft. Lease holders serve reads locally, avoiding the latency of consensus for read-heavy workloads. |
| [Kafka](../oss/kafka/README.md) | KRaft (Kafka Raft) replaces the previous ZooKeeper dependency for metadata management. The KRaft controller quorum manages cluster metadata (topic configurations, partition assignments, broker registrations) using a Raft-based replicated log. This simplifies deployment by removing the ZooKeeper operational burden. |
| [Consul](../oss/consul/README.md) | Server agents form a Raft consensus cluster (typically 3 or 5 nodes) to maintain strongly consistent cluster state. All writes flow through the Raft log using the hashicorp/raft library. Raft-Autopilot automates server health monitoring and dead-server cleanup. The WAL-based LogStore provides efficient append-only log persistence. |
| [Dgraph](../oss/dgraph/README.md) | Zero nodes form a separate Raft group managing cluster-wide metadata including group membership and predicate-to-group assignments. Alpha groups each run independent Raft instances for data replication. Uses etcd's Raft library, with mutations proposed through Raft for consistency across replicas. |

## Multi-Version Concurrency Control (MVCC)

Each write creates a new version of the data rather than overwriting in place. Readers access a consistent snapshot at a specific version/timestamp without blocking writers. Old versions are eventually garbage collected. MVCC enables high-concurrency transactional workloads.

| Project | Implementation Details |
|---|---|
| [etcd](../oss/etcd/README.md) | Uses a monotonically increasing revision number as the version identifier. Each key-value mutation creates a new revision, and the revision-to-value mapping is stored in bbolt. Watchers can observe changes from any historical revision, enabling event-driven architectures. Periodic compaction removes old revisions to bound storage growth. |
| [TiKV](../oss/tikv/README.md) | Implements the Percolator distributed transaction model using three RocksDB Column Families: `CF_DEFAULT` stores versioned values, `CF_LOCK` tracks in-progress transaction locks, and `CF_WRITE` records commit timestamps. The timestamp oracle (provided by PD) assigns globally unique, monotonically increasing timestamps to transactions. |
| [CockroachDB](../oss/cockroachdb/README.md) | Uses Hybrid Logical Clocks (HLC) for MVCC timestamps, combining physical wall-clock time with a logical counter to achieve both causality tracking and clock-skew tolerance. All key-value data is stored with HLC timestamps, and reads at a specific timestamp see a consistent snapshot. The transaction layer implements serializable snapshot isolation (SSI). |
| [RocksDB](../oss/rocksdb/README.md) | Maintains a `VersionSet` that tracks the current set of SST files constituting the database state. Each `Version` is an immutable snapshot of the LSM-tree structure. Compaction creates new Versions while old ones remain accessible to ongoing iterators, enabling consistent reads without locking. |
| [Dgraph](../oss/dgraph/README.md) | Posting lists use an immutable base plus mutable delta layer design for MVCC. Reads at a specific timestamp merge the base with relevant deltas. The rollup process periodically merges deltas into a new base to prevent unbounded delta growth, balancing read performance and write efficiency. |
| [DuckDB](../oss/duckdb/README.md) | Implements MVCC to provide snapshot isolation for concurrent transactions. Updates create new versions rather than overwriting data. Garbage collection removes old versions after transactions complete. While optimized for analytical workloads, DuckDB supports transactional updates with ACID guarantees. |
| [Go-Ethereum](../oss/go-ethereum/README.md) | The state trie uses MVCC semantics through versioned trie nodes. The VersionSet in the path-based storage scheme tracks snapshots of trie structure. Ongoing state readers access immutable versions while writers create new versions, enabling concurrent reads without blocking state transitions. |

## Middleware / Chain of Responsibility

A request passes through a sequence of independent handlers, each of which can inspect, modify, or short-circuit the request before passing it to the next handler. This pattern decouples cross-cutting concerns (authentication, logging, rate limiting) from business logic.

| Project | Implementation Details |
|---|---|
| [Envoy](../oss/envoy/README.md) | HTTP filter chains are the primary extension mechanism. Filters like rate limiting, authentication, CORS, and routing are composed into a chain. Each filter can read/modify headers and body, pause processing to make async calls (e.g., to an external auth service), or terminate the request with an error response. |
| [CoreDNS](../oss/coredns/README.md) | DNS query handling follows a strict plugin chain defined at compile time by `plugin.cfg`. Each plugin's `ServeDNS` method processes the query, optionally modifies it, and calls `plugin.NextOrFailure()` to pass control to the next plugin. Plugins earlier in the chain (like `cache`) can short-circuit by returning a cached response. |
| [Caddy](../oss/caddy/README.md) | HTTP handler modules are composed into middleware chains. Each handler wraps the next, forming a Russian-doll nesting pattern. Matchers determine which requests reach which handler chains, enabling conditional middleware application. The `encode`, `headers`, and `rewrite` modules are typical middleware examples. |
| [Kubernetes](../oss/kubernetes/README.md) | Admission controllers form a chain that intercepts API requests after authentication and authorization. Mutating admission webhooks run first (can modify the object), followed by validating admission webhooks (can only accept/reject). This chain enables policy enforcement, defaulting, and side-car injection without modifying core API logic. |
| [etcd](../oss/etcd/README.md) | The `UberApplier` uses a decorator chain pattern where applier functions wrap each other to layer on cross-cutting concerns (quota checking, corruption detection, capped alarm, authentication) around the core apply logic. Each decorator adds a specific behavior before delegating to the inner applier. |

## Work-Stealing Scheduler

A pool of worker threads each maintain a local task queue. When a worker's queue is empty, it "steals" tasks from other workers' queues. This approach balances load dynamically without a central dispatcher, achieving high CPU utilization with low synchronization overhead.

| Project | Implementation Details |
|---|---|
| [Tokio](../oss/tokio/README.md) | The multi-threaded runtime uses a work-stealing scheduler where each worker thread has a fixed-size local queue (256 slots). A global injection queue handles overflow and external task submissions. A LIFO slot optimization ensures that newly spawned tasks run immediately on the spawning worker, improving cache locality. Workers periodically check the global queue to prevent starvation. |
| [Spark](../oss/spark/README.md) | The `TaskScheduler` employs a two-level scheduling model. The `DAGScheduler` breaks jobs into stages, and the `TaskScheduler` assigns tasks to executors with data locality awareness (PROCESS_LOCAL, NODE_LOCAL, RACK_LOCAL). While not strictly work-stealing at the executor level, speculative execution re-launches slow tasks on other executors to mitigate stragglers. |
| [Bevy](../oss/bevy/README.md) | The ECS scheduler analyzes system data access patterns to build a dependency DAG, then dispatches independent systems to a thread pool for parallel execution. Systems that access disjoint component sets run simultaneously without synchronization, effectively distributing work across available cores based on data dependencies rather than explicit task assignment. |

## Declarative Reconciliation Loop

The system continuously compares the desired state (declared by the user) with the actual state (observed from the environment) and takes corrective actions to converge toward the desired state. This level-triggered approach is inherently self-healing — transient failures are automatically retried.

| Project | Implementation Details |
|---|---|
| [Kubernetes](../oss/kubernetes/README.md) | The controller pattern is the foundation of Kubernetes' architecture. Each controller watches specific resource types via SharedInformers (which maintain a local cache synchronized with the API server via watch streams). When a discrepancy is detected between `.spec` (desired) and `.status` (actual), the controller takes action. The level-triggered design means controllers respond to the current state, not to events — making them resilient to missed notifications. |
| [React](../oss/react/README.md) | The Fiber reconciler compares the current virtual DOM tree with a new one produced by rendering. It walks the tree, identifying differences (additions, deletions, updates), and produces a minimal set of mutations to apply to the host environment (DOM, native views, etc.). The double-buffering technique (current tree vs. work-in-progress tree) enables interruptible reconciliation with priority-based scheduling. |
| [Flink](../oss/flink/README.md) | The distributed snapshot mechanism (based on Chandy-Lamport) periodically captures consistent global state across all operators. On failure, the entire dataflow graph is rolled back to the last successful checkpoint and replayed from that point. The system continuously reconciles the running topology against the JobGraph specification, restarting failed tasks and reallocating resources. |

## Actor Model / Finite State Machine

Concurrent entities (actors) communicate exclusively through asynchronous message passing, with each actor processing messages sequentially from its mailbox. Combined with finite state machines, this pattern enables modeling complex stateful protocols without shared mutable state.

| Project | Implementation Details |
|---|---|
| [TiKV](../oss/tikv/README.md) | The `BatchSystem` implements a mailbox-based actor model using finite state machines (`PeerFsm` and `StoreFsm`). Each Raft peer is an FSM that processes messages (Raft proposals, snapshots, region splits) from its mailbox. The `PollHandler` batches messages for efficiency, and the Router delivers messages to the correct FSM based on region ID. |
| [Flink](../oss/flink/README.md) | Uses Akka for RPC communication between the JobManager and TaskManagers. Each component (ResourceManager, Dispatcher, JobMaster, TaskExecutor) is modeled as an RPC endpoint with an actor-like message processing model. This enables location-transparent communication and failure detection across the cluster. |
| [Prometheus](../oss/prometheus/README.md) | Uses the `oklog/run` library to orchestrate concurrent subsystems as independent actors. Each actor (scrape manager, rule manager, TSDB, web UI, notifier) runs in its own goroutine with well-defined lifecycle (start/stop) semantics. The run group coordinates graceful shutdown — when any actor fails, all others are signaled to stop. |

## Distributed Snapshots / Checkpointing

A mechanism to capture a globally consistent snapshot of distributed state without pausing the entire system. Typically achieved by injecting barrier markers into data streams and coordinating state capture at each processing node when barriers are received.

| Project | Implementation Details |
|---|---|
| [Flink](../oss/flink/README.md) | Implements the Chandy-Lamport algorithm via checkpoint barriers injected by the source operators. When an operator receives barriers from all input channels, it snapshots its local state to a distributed storage backend (RocksDB, filesystem, or S3). This provides exactly-once processing semantics without stopping the pipeline. Unaligned checkpoints allow barriers to overtake in-flight records, reducing checkpoint latency for backpressured pipelines. |
| [Kafka](../oss/kafka/README.md) | Consumer group offsets serve as lightweight checkpoints — each consumer periodically commits the offset of the last processed message. On failure recovery, processing resumes from the last committed offset. Combined with transactions (two-phase commit), Kafka enables exactly-once semantics across produce-consume pipelines. |
| [Spark](../oss/spark/README.md) | RDD lineage provides an implicit checkpointing mechanism — lost partitions are recomputed by replaying the transformation DAG from the parent RDDs. Explicit checkpointing (`RDD.checkpoint()`) materializes an RDD to reliable storage, truncating the lineage graph. Structured Streaming uses write-ahead logs and offset tracking for exactly-once guarantees. |

## Content-Addressable Storage

Objects are stored and retrieved by the hash of their content rather than by name or location. This guarantees deduplication (identical content produces the same hash), simplifies integrity verification, and enables efficient caching and distribution.

| Project | Implementation Details |
|---|---|
| [containerd](../oss/containerd/README.md) | All container image content (layers, manifests, configs) is stored by content digest (SHA-256). The content store provides a flat namespace of immutable blobs. Garbage collection uses a label-based reference tracking system — objects with GC root labels or referenced by other labeled objects are retained. This design naturally deduplicates shared base image layers across containers. |
| [RocksDB](../oss/rocksdb/README.md) | SST files are immutable once written and are identified by monotonically increasing file numbers. While not hash-addressed, the immutability property enables similar benefits: concurrent readers access files without locking, and compaction produces new files rather than modifying existing ones. The `VersionSet` tracks which files constitute the current database state. |
| [Trivy](../oss/trivy/README.md) | Distributes vulnerability databases, check bundles, and Java indexes as OCI Artifacts via container registries (GHCR). OCI Artifacts use content-addressable layers with digest-based integrity verification. The BlobKey-based cache in Trivy's scanner uses content hashes of container image layers to skip re-analysis of previously scanned layers. |

## Sidecar Pattern

A companion process runs alongside the main application, providing cross-cutting functionality like security, networking, or observability without requiring application code changes. The sidecar and application share a lifecycle but communicate via localhost networking or IPC.

| Project | Implementation Details |
|---|---|
| [Dapr](../oss/dapr/README.md) | Each application instance runs with a daprd sidecar process providing building blocks (state management, pub/sub, service invocation, actors, secrets, configuration) via HTTP/gRPC APIs. The sidecar handles distributed computing concerns while applications remain language-agnostic and infrastructure-independent. Automatic mTLS between sidecars via Sentry CA secures service-to-service communication. |

## Dependency Injection

Components receive their dependencies through constructors, setters, or framework mechanisms rather than creating them directly. This pattern decouples components from their dependencies, enabling testability, configurability, and runtime flexibility in component composition.

| Project | Implementation Details |
|---|---|
| [Angular](../oss/angular/README.md) | Implements hierarchical dependency injection with two parallel injector trees: EnvironmentInjector for application-level services and ElementInjector for component-level dependencies. Resolution walks ElementInjector first, then EnvironmentInjector. The inject() function enables functional composition and usage in factory functions. Modifiers like @Optional(), @Self(), @SkipSelf(), and @Host() provide fine-grained control. |
| [Backstage](../oss/backstage/README.md) | Backend plugins receive service instances (database, logger, config, HTTP router, scheduler) through the backend plugin API via dependency injection. The service registry manages instances and lifecycle. Frontend uses React context and hooks for dependency injection, with UtilityAPIs providing cross-cutting services. |
| [Dapr](../oss/dapr/README.md) | The component loaders use dependency injection to provide components with required interfaces. Components declare dependencies on interfaces rather than concrete implementations, enabling swapping between state stores, pub/sub brokers, and secret stores without code changes. |
| [Gitea](../oss/gitea/README.md) | The CliFactory (cli/factory.rs) acts as a dependency injection container, lazily constructing components like file fetcher, module graph, resolver, npm installer, and worker factory. Services receive their dependencies through the factory pattern, enabling testability and modular composition. |

## References

- [The Architecture of Open Source Applications (AOSA)](https://aosabook.org/) — Prior art in OSS architecture documentation
- [Design Patterns: Elements of Reusable Object-Oriented Software](https://en.wikipedia.org/wiki/Design_Patterns) — Foundational design patterns reference
- [Martin Fowler's Patterns of Enterprise Application Architecture](https://martinfowler.com/eaaCatalog/) — Enterprise integration patterns
- Individual project reports in the [oss/](../oss/) directory of this repository
