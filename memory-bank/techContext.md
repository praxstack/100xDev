# Tech Context — Prax's Technical Stack & Learning Environment

## Current Technical Skills

### Languages
| Language | Proficiency | Notes |
|----------|-------------|-------|
| Java | 9/10 (Basic), 2/10 (Advanced) | Strong syntax, weak in concurrency/collections internals |
| JavaScript | Solid | React.js, Node.js, Redux |
| C++ | Familiar | Academic background |
| HTML/CSS | Solid | Front-end development |
| VTL | Experienced | Amazon template language |
| Python | Basic | Scripting, automation |

### Front-End
- **React.js** (SSR & CSR): Solid production experience
- **Redux**: State management
- **AppSync**: GraphQL resolvers
- **SSR Performance**: Reduced p90 latency by 47%

### Back-End
- **Node.js/Express**: API development
- **Spring Boot**: Java backend services
- **Google Guice**: Dependency injection
- **GraphQL**: API design and implementation
- **REST**: Standard API patterns

### Cloud & AWS (Production Experience)
| Service | Experience Level | Usage Context |
|---------|-----------------|---------------|
| Lambda | Production | Serverless functions |
| DynamoDB | Production | NoSQL database |
| Step Functions | Production | Workflow orchestration |
| AppSync | Production | GraphQL APIs |
| CloudWatch | Production | Monitoring, logging |
| ECS | Production | Container orchestration |
| CDK | Production | Infrastructure as Code |
| API Gateway | Production | API management |
| S3 | Production | Object storage |

### Databases
- **DynamoDB**: Primary production experience
- **NoSQL**: Strong understanding from Amazon
- **SQL**: Academic + some production

### Development Practices
- Git/GitHub
- CI/CD pipelines
- Test-Driven Development (TDD)
- Agile/Scrum methodology
- PTG documentation (Amazon)
- On-call support experience

---

## Learning Resources

### Active Platforms
| Platform | Focus | Status |
|----------|-------|--------|
| CodeCrafters.io | Build-your-own projects | Active |
| Educative.io | System Design, DSA | Active |
| 100xDevs Bootcamp | Web3, AI/ML, DevOps, DSA | Starting Jan 2026 |

### Current Project: Build Your Own Shell (Java)
**Platform:** CodeCrafters.io

#### Connection to Deeper Concepts
| Stage Concept | Connects To |
|---------------|-------------|
| Command parsing | DSA: String manipulation, tokenization |
| PATH lookup | DSA: Search algorithms, caching |
| Process execution | System Design: Process isolation, containers |
| Piping | System Design: Stream processing, Unix philosophy |
| Signal handling | Concurrency: Thread interruption, graceful shutdown |
| Built-ins vs externals | Design Patterns: Command pattern, Strategy |

---

## Learning Gap Analysis

### DSA (Current: 2/10)
| Topic | Status | Priority |
|-------|--------|----------|
| Arrays, Strings | ✅ Solid | — |
| Searching, Sorting | ✅ Solid | — |
| Linked Lists | ⚠️ Rusty | High |
| Trees (Binary, BST) | ❌ Forgotten | Critical |
| Graphs (DFS, BFS) | ❌ Forgotten | Critical |
| Dynamic Programming | ❌ Forgotten | Critical |
| Heaps | ❌ Forgotten | Critical |
| Tries | ❌ Never learned deeply | High |
| Sliding Window | ⚠️ Rusty | High |
| Two Pointers | ⚠️ Rusty | High |

### Java Advanced (Current: 2/10)
| Topic | Status | Priority |
|-------|--------|----------|
| Multithreading basics | ❌ Weak | Critical |
| Concurrency (ExecutorService) | ❌ Weak | Critical |
| Collections internals (HashMap) | ❌ Weak | Critical |
| Streams API | ⚠️ Basic | High |
| Generics deep dive | ⚠️ Basic | High |
| JVM internals | ❌ None | Medium |

### System Design (Current: 0/10)
| Topic | Status | Priority |
|-------|--------|----------|
| Fundamentals | ❌ Never studied | Critical |
| CAP Theorem | ❌ Never studied | Critical |
| Database Design | ⚠️ Some practical | High |
| Caching | ⚠️ Some practical | High |
| Load Balancing | ❌ None | High |
| Microservices | ⚠️ Built at Amazon | High |
| Message Queues | ❌ None | High |

### Design Principles (Current: 0/10)
| Topic | Status | Priority |
|-------|--------|----------|
| SOLID Principles | ❌ None | Critical |
| Design Patterns | ❌ None | Critical |
| Clean Code | ⚠️ Intuitive | High |
| Refactoring | ⚠️ Intuitive | High |

---

## Development Environment

### Tools Available
- **IDE:** VS Code, IntelliJ IDEA (likely)
- **Terminal:** zsh (macOS)
- **Version Control:** Git, GitHub, GitLab
- **Containers:** Docker
- **Cloud CLI:** AWS CLI, gcloud, kubectl
- **Package Managers:** npm, yarn, pnpm, pip, cargo, maven

### Machine Info
- **OS:** macOS
- **Shell:** zsh
- **Location:** /Users/praxlannister/Documents/workspace/100xDev

---

## Technology Selection Principles

### For Learning Projects
1. **Java First:** Primary language for DSA and advanced concepts
2. **Build, Don't Configure:** Prefer building from scratch over frameworks
3. **Understand, Don't Memorize:** Focus on internals, not just APIs

### For Production Code
1. **Use Existing Libraries:** Don't reinvent solved problems
2. **Type Safety:** TypeScript for JS, proper types in Java
3. **Test Coverage:** TDD where possible

---

## Observability & Debugging

### From Amazon Experience
- CloudWatch for metrics and logging
- Structured logging practices
- On-call ticket management
- Production debugging skills

### To Learn
- Distributed tracing
- Performance profiling (JVM)
- Memory leak detection

---

## Security Awareness

### From Amazon Experience
- Basic security practices in production
- API authentication patterns
- Data handling practices

### To Learn (System Design)
- Threat modeling
- Authentication/Authorization deep dive
- Encryption at rest/in transit
- Security in distributed systems

---

*Last Updated: January 2026*