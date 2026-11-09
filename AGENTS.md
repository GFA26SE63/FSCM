## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

When the user types `/graphify`, use the installed graphify skill or instructions before doing anything else.

Rules:
- When graphify-out/graph.json exists, run `graphify query "<question>"` before your first grep, search or source-file read for a codebase question, and put this rule in every subagent prompt that explores code. Read raw files only for lines the graph or an earlier read already located. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- Dirty graphify-out/ files are expected after hooks or incremental updates; dirty graph files are not a reason to skip graphify. Only skip graphify if the task is about stale or incorrect graph output, or the user explicitly says not to use it.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).
- A committed graphify-out/graph.json is rewritten whole on every build, so a large diff to it in a pull request is expected. Do not flag it as churn or suggest skipping the graph rebuild or its hooks.

## Shared implementation workflow: Backend, Frontend, and Mobile

### Configurable settings

Change the branch value below when work must use another branch. Every affected
repository must use the same branch.

```text
IMPLEMENTATION_BRANCH=feature/hai-sprint
INTEGRATION_BRANCH=develop
GITHUB_REMOTE=origin
```

`FSCM-Backend`, `FSCM-Frontend`, and `FSCM-Mobile` are independent Git
repositories. Do not assume they share a commit, worktree, or remote. Do not
create empty commits in repositories without changes.

### Sources of truth and scope

- The user's newest direct request has the highest priority.
- Before every implementation, read `temp/FSCM_Business_Baseline.md` to
  understand the system context. When work also involves a business rule or
  contract, read `temp/guideline.md` and the relevant task/SRS documents before
  changing code. `temp/` is internal context and must never be committed.
- For cross-platform features, establish the shared contract first: API route,
  DTO, GUID/code identity, authorization, state transition, errors, and side
  effects. The backend is authoritative for business rules; frontend and mobile
  clients must not duplicate or reinterpret server-side rules.
- For common business read models—especially list, search, filter, pagination,
  and detail views—frontend and mobile must use GraphQL. Define the GraphQL
  query and typed client contract so each screen selects only the fields it can
  display; do not fetch a REST read model and reshape it on the client unless a
  documented `N/A` reason applies. REST remains the default for command
  workflows and other state-changing operations.

### Mandatory gate before implementation

Apply these steps in **each repository that will be changed**, before any
tracked source or configuration change:

1. Check `git status --short --branch`, the current branch, and `git remote -v`.
   If the worktree contains changes of unclear origin, do not reset, checkout,
   stash, delete, or overwrite them.
2. Run `git fetch origin --prune`.
3. Switch to `IMPLEMENTATION_BRANCH` (creating it from `origin/develop` if it
   does not exist), then integrate the latest `origin/develop` into that branch.
   Fast-forward when possible; if histories diverge, merge safely or stop and
   report conflicts—never force-push, hard-reset, or blindly rebase.
4. Confirm the branch decision, `origin/develop` base, and in-scope repositories
   before coding.

Safe example when the branch exists and the worktree is clean:

```powershell
git fetch origin --prune
git switch feature/hai-sprint
git merge origin/develop
```

If the branch does not exist, create it from the latest `origin/develop`, then
push its upstream. Do not commit directly to `develop` or `main` unless the user
explicitly requests it.

### Implementation rules

- Make small, reviewable changes that follow each application's architecture.
- Backend: keep domain, application, persistence, and API layers separate; add
  validation, role and resource-scope authorization, transactions, idempotency,
  concurrency, and audit/outbox behavior when the feature needs them.
- Frontend: use typed API contracts, handle loading/error/empty states, never put
  secrets in the bundle, and never replace authorization with hidden UI. Before
  implementing UI, prioritize reusing existing shared components; when no
  suitable component exists, create a reusable component that can serve the
  wider system rather than a one-off implementation.
- Mobile: keep remote, local, and offline boundaries clear; secure local tokens
  and secrets; do not alter the server's authoritative business result. Before
  implementing UI, prioritize reusing existing shared widgets; when no suitable
  widget exists, create a reusable widget that can serve the wider system rather
  than a one-off implementation.
- When changing an API or schema, update client contracts, Swagger/GraphQL/docs,
  and cross-platform contract tests in the same work.
- When changing a tracked secret/config example or template (for example,
  `.env.example`, `appsettings.example.json`, or `env/development.example.json`),
  update the corresponding ignored local secret/config file at the same time so
  their keys and structure stay synchronized. Preserve existing local values,
  never print them, and never commit the ignored file.
- Never commit `temp/`, build artifacts, local appsettings, `.env`, database
  dumps, API keys, passwords, or secrets.

### Mandatory migrations and seed data

After every implementation with backend or data impact:

The project has exactly one development database. Its connection and secrets are
configured in the local, Git-ignored appsettings file. Treat that configured
database as the verified development target: run migrations and the normal
seeder without requiring additional confirmation, while never printing or
committing its connection string or secrets. The canonical default password for
all accounts created by the development seeder is `LogisticsThesis@123`; keep
the local `SeedData:DefaultPassword` setting synchronized with this value.

1. Create a forward-only migration when the schema changes; never edit an applied
   migration.
2. Review the migration, snapshot, indexes, FK/unique/check constraints, and
   required data backfills.
3. Run migrations only against a verified **local/development database**.
4. Run the normal seeder, verify idempotency, and smoke-test the data/API.
5. Seed/demo data with natural-language content must be Vietnamese; never log or
   hard-code secrets. Do not run destructive seed/drop operations against
   production or an unidentified environment.

For frontend-only or mobile-only work with no backend/data impact, still verify
the contract against the running backend. Migration/seed may only be skipped when
no local database is configured or the operation could affect non-development
data; record the reason in the handoff.

### Quality gate before commit

Run the complete applicable checks in every affected repository (and the full
workspace suite whenever feasible), at minimum:

```powershell
# FSCM-Backend
dotnet restore FSCM.slnx
dotnet build FSCM.slnx --configuration Release --no-restore
dotnet test FSCM.slnx --configuration Release --no-build

# FSCM-Frontend
npm run lint
npm run test --if-present
npm run build

# FSCM-Mobile
flutter pub get
flutter analyze
flutter test
```

Add unit, integration, REST/GraphQL contract, migration/schema, provider-failure,
authorization, and idempotency/concurrency tests according to feature risk. Do
not alter tests merely to legitimize behavior that violates the baseline.

Before committing, always run:

```powershell
git status --short
git diff --check
git diff
git diff --cached
```

Continue only when tests pass, migrations/seeding (when applicable) pass, the
diff is in scope, and no unintended secret, temp file, or artifact exists.

### Commit, push, and Azure mirroring

- Create logical commits using Conventional Commits:
  `<type>(<scope>): <imperative summary>`.
- Example types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `build`,
  `ci`.
- A successful pre-commit quality gate is sufficient for the unchanged committed
  diff; do not rerun the full gate after committing. Run post-commit validation
  only when the commit process or a hook changes files. Push only when the
  applicable validation passes. If a check fails, fix it in a subsequent
  Conventional Commit rather than rewriting/amending the existing commit, unless
  the user explicitly requests otherwise.
- Commit separately in every repository with changes, then push to GitHub:

```powershell
git push -u origin feature/hai-sprint
```

- Push only to GitHub remote `origin`; **do not push to Azure DevOps**. GitHub
  Actions is responsible for mirroring to Azure DevOps.
- Do not force-push, automatically merge a PR into `develop`/`main`, or create a
  tag/release unless the user explicitly requests it.
- If a push is rejected, fetch and safely assess divergence/conflicts; never
  overwrite another person's work.

### Mandatory handoff

After each implementation, report for every repository:

- branch, `develop` base, commit SHA, and `origin` push status;
- API/GraphQL/contract, migration, and seed operations performed, without
  exposing secrets;
- complete build/test results;
- `develop` as the PR target, if a PR is needed;
- every blocker, test that could not run, or skipped migration/seed and why.
