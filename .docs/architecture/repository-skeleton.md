# FMCG repository skeleton assessment

## 1. Executive Skeleton Assessment

The FMCG monorepo is appropriate for a thesis-level full-stack system. Because it is in the design/skeleton phase, it should be assessed by architectural readiness, consistency, maintainability, SOLID readiness, test boundaries, and DevOps preparedness—not by feature completeness.

The refined structure gives the .NET backend explicit architectural boundaries, keeps React and Flutter as independent API consumers, provides generic feature templates, and reserves named placeholders only for the finalized cross-cutting conventions: optimistic concurrency, immutable audit logging, database-driven RBAC, and base-unit UoM conversion. It is capable of hosting expiry-sensitive and concurrency-sensitive logic later without pre-committing to unapproved business modules.

## 2. Recommended Monorepo Work Tree

`[skeleton]` means a committed source/documentation boundary. `[ignored]` means generated or local content that must not be committed.

```text
FMCG/
├── .azure/                                      [skeleton]
│   └── pipelines/
│       ├── application-delivery.yaml
│       ├── templates/
│       └── variables/
├── .docs/                                       [skeleton]
├── .github/                                     [skeleton]
├── backend/                                     [skeleton]
│   ├── FMCG.slnx
│   ├── src/
│   ├── tests/
│   ├── .vs/                                     [ignored]
│   └── **/{bin,obj}/                            [ignored]
├── frontend/                                    [skeleton]
│   ├── public/
│   ├── src/
│   ├── node_modules/                            [ignored]
│   └── dist/                                    [ignored]
├── mobile/                                      [skeleton]
│   ├── lib/
│   ├── test/
│   ├── platform folders/
│   ├── .dart_tool/                              [ignored]
│   ├── build/                                   [ignored]
│   └── **/ephemeral/                            [ignored]
├── README.md
└── .gitignore
```

Generated folders may exist locally after restore or build, but their presence is not part of the reviewed repository structure.

## 3. Backend .NET 10 Clean Architecture and SOLID Skeleton

Project responsibilities:

- `FMCG.Domain`: enterprise rules and persistence-agnostic domain types; no outward project dependencies.
- `FMCG.Application`: use-case orchestration, application contracts, feature DTOs, validators, and mappings.
- `FMCG.Persistence`: Entity Framework database context, mappings, migrations, repositories, and persistence interceptors implementing Application ports.
- `FMCG.Infrastructure`: adapters for external providers, authorization evaluation, audit writers, caching, files, and background services implementing Application ports.
- `FMCG.API`: composition root and HTTP/transport boundary; configuration, middleware, controllers/endpoints, and transport contracts.
- `FMCG.Shared`: a deliberately small set of stable, dependency-free technical primitives; never a miscellaneous dumping ground.

Recommended backend tree:

```text
backend/
├── FMCG.slnx
├── src/
│   ├── FMCG.API/
│   │   ├── Contracts/
│   │   ├── Controllers/
│   │   ├── Extensions/
│   │   ├── Filters/
│   │   ├── Middleware/
│   │   ├── Options/
│   │   └── Program.cs
│   ├── FMCG.Application/
│   │   ├── Abstractions/
│   │   ├── Common/
│   │   │   ├── Audit/
│   │   │   ├── Concurrency/
│   │   │   └── UnitOfMeasure/
│   │   └── Features/
│   │       └── _template/
│   │           ├── Commands/
│   │           ├── Queries/
│   │           ├── DTOs/
│   │           ├── Validators/
│   │           └── Mappings/
│   ├── FMCG.Domain/
│   │   ├── Common/                 # GUID Id, RowVersion, soft-delete, timestamps
│   │   ├── Enums/
│   │   ├── Events/
│   │   ├── Services/
│   │   └── ValueObjects/
│   ├── FMCG.Infrastructure/
│   │   ├── Audit/                  # hash-chain writer placeholder
│   │   ├── Rbac/                   # permission evaluator placeholder
│   │   └── ExternalServices/
│   │       └── _template/
│   ├── FMCG.Persistence/
│   │   ├── Configurations/
│   │   │   └── _template/
│   │   ├── DbContexts/
│   │   ├── Interceptors/           # concurrency/audit placeholder
│   │   └── Migrations/
│   └── FMCG.Shared/
└── tests/
    ├── FMCG.UnitTests/
    ├── FMCG.IntegrationTests/
    └── FMCG.LoadTests/
```

Dependency direction:

```text
Application    ──> Domain, Shared
Persistence    ──> Domain, Application abstractions
Infrastructure ──> Application abstractions
API            ──> Application, Persistence, Infrastructure
Domain         ──> no other project
Shared         ──> no other project
```

More precisely, Persistence depends on Domain and Application abstractions; Infrastructure depends on Application abstractions and provider packages; API composes Application, Persistence, and Infrastructure. The compile-time project-reference graph should enforce this direction.

The structure supports Single Responsibility by isolating transport, use cases, domain policy, database mechanics, and provider mechanics. Small ports in Application support Interface Segregation and Dependency Inversion. Concurrency, audit, RBAC, and UoM each have a narrow generic home, so Application and Domain do not depend on Entity Framework, database schemas, or provider SDKs. Substitutability and extension are verified later through contract tests and alternative adapters, not claimed from folder names alone.

## 4. Backend DTO and Contract Skeleton

Feature-owned command/query DTOs, validators, and mappings belong together in `FMCG.Application/Features/<approved-feature>/`. Cross-feature application ports belong in `FMCG.Application/Abstractions/`. HTTP-only request/response shapes belong in `FMCG.API/Contracts/` when they are not the feature's application contract. Validation runs at the boundary and/or application use-case boundary without placing transport concerns in Domain.

React and Flutter consume versioned API contracts, never Entity Framework entities or database models. Actual DTOs, routes, mappings, and workflows should wait for the approved API and business design.

## 5. Frontend React/TypeScript Skeleton

The React application should use a feature-oriented structure with a small shared UI/core surface:

```text
frontend/src/
├── app/
├── assets/
├── components/
├── config/
├── features/
│   └── _template/
│       ├── api/
│       ├── components/
│       ├── hooks/
│       ├── pages/
│       ├── schemas/
│       └── types/
├── hooks/
├── layouts/
├── lib/
│   └── rbac/                     # permission UI placeholder
├── pages/
├── routes/
├── services/
│   └── api/                      # central API client
├── store/
├── types/
├── utils/
└── tests/
```

All HTTP calls should flow through the central API client, whose base URL comes from `VITE_API_BASE_URL`. Once the backend RBAC contract is approved, `lib/rbac/` can host generic route guards and conditional-rendering helpers. Client-side permission checks improve the user experience but never replace server authorization.

## 6. Mobile Flutter Skeleton

Because Flutter is currently an API-consuming client, a lightweight feature-based structure is sufficient:

```text
mobile/lib/
├── app/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/                  # central API service
│   └── utils/
├── config/
├── shared/
│   ├── widgets/
│   ├── models/
│   ├── services/
│   └── rbac/                     # permission UI placeholder
├── features/
│   └── _template/
│       ├── pages/
│       ├── widgets/
│       ├── models/
│       ├── services/
│       └── controllers/
├── routes/
└── main.dart
```

The centralized HTTP service reads its base URL from `--dart-define` configuration. Full data/domain/presentation layering should be introduced only if mobile later gains substantial local business rules, offline-first synchronization, local persistence complexity, or multiple data sources.

## 7. API Contract Alignment Skeleton

The backend remains the integration center. Swagger/OpenAPI should publish the canonical REST contract; `.docs/api/` records versioning policy, examples, and review decisions. React and Flutter may use generated clients or manually maintained models, but generation should be deterministic and the generated outputs should have clear ownership. Contract changes should be versioned and checked in CI once the API design stabilizes.

## 8. Azure DevOps CI/CD Skeleton Mainly for Backend

The delivery boundary is:

```text
.azure/pipelines/
├── application-delivery.yaml
├── templates/
└── variables/
scripts/backend/
infra/
```

`.azure/` is valid and already established; `.azuredevops/` is slightly more explicit but offers no technical advantage. Renaming now would add churn, so consistency with `.azure/` is preferable.

The backend pipeline performs restore/build, automated tests, API publish, ZIP packaging, and pipeline-artifact publication. A main-branch deployment stage exists only as a disabled placeholder until the Azure hosting target, environments, approvals, service connection, and secret strategy are approved. Frontend and mobile pipelines can be added independently later.

## 9. Backend Pipeline Trigger Skeleton

Backend CI/PR triggers include:

```yaml
paths:
  include:
    - backend/**
    - .azure/pipelines/**
    - scripts/backend/**
    - infra/**
```

Frontend-only and mobile-only changes therefore do not start backend delivery. If shared API contract files later live outside `backend/`, their exact path must be added to the include list.

## 10. Git and Repository Hygiene

Commit source skeletons, project/solution files, automated tests, pipeline YAML, scripts, documentation, infrastructure definitions, and deterministic lock files. Keep `frontend/package-lock.json` and `mobile/pubspec.lock`.

Do not commit `.NET bin/obj/.vs`, `node_modules`, `dist`, `.dart_tool`, Flutter `build` or `ephemeral` outputs, test results, logs, secrets, certificates, local environment files, or real deployment settings. Commit only safe examples such as `.env.example` and `appsettings.example.json`. Store real values later in .NET user secrets for development and Azure DevOps variable groups, Key Vault, or secret pipeline variables for delivery.

## 11. Documentation Skeleton

```text
docs/
├── architecture/      # boundaries, decisions, dependency rules
├── api/               # contract/versioning documentation
├── database/          # approved model and migration guidance
├── devops/            # pipeline, environments, release process
├── diagrams/          # thesis diagrams and editable sources
└── testing/           # strategy, test levels, quality evidence
```

Prefer short, version-controlled decision records and diagrams whose source files are committed alongside exported images.

## 12. Academic and Enterprise Justification

Before feature implementation, the repository already demonstrates separation of concerns, SOLID and Clean Architecture readiness, scalable monorepo organization, distinct backend/web/mobile ownership, a backend API integration center, delivery automation, three backend test scopes, and thesis-friendly documentation boundaries. The concurrency, audit, RBAC, and UoM placeholders show where finalized architectural conventions will be implemented without pretending that unapproved business modules exist.

## 13. Pitfalls and Recommendations

- Generated files: enforce `.gitignore` and review `git status` before every commit.
- Duplicated API models: choose one OpenAPI-based alignment process when contracts stabilize.
- Noisy history: keep commits scoped by stack or architectural concern.
- Wasteful pipelines: retain path filters and add shared-contract paths deliberately.
- Configuration drift: document variable names once and keep safe examples synchronized.
- Shared-folder misuse: promote code to shared scope only after demonstrated reuse and stable semantics.
- Circular backend dependencies: enforce references through solution/build checks and architecture tests later.
- Premature client architecture: keep React and Flutter feature-based until complexity justifies more layers.
- Premature cross-cutting implementation: keep concurrency, audit, RBAC, and UoM as contracts/placeholders until transaction, threat, performance, and domain requirements are confirmed.

## 14. Final Verdict

The refined skeleton is suitable for an FPT University graduation thesis and credible as the foundation of an enterprise-style system. It demonstrates architectural and delivery readiness without misrepresenting skeleton placeholders as completed business functionality. The next responsible milestone is approval of the domain and API design, followed by one thin vertical slice that proves the boundaries and cross-cutting conventions end to end.
