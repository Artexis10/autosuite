# Provisioning

> **Status:** MVP — functional, evolving

Machine provisioning and configuration management. The core system of Automation Suite.

---

## The Prime Directive

> If Provisioning cannot be safely re-run at any time, it is incomplete.

---

## Purpose

Provisioning transforms a machine from an unknown state into a known, verified desired state.

It installs software, restores configuration, and verifies outcomes — safely, repeatably, and without guesswork.

---

## Manifesto

### 1. Desired state over imperative steps

Describe *what should be true*, not a sequence of shell commands. The system decides how to reach that state.

### 2. Idempotence is mandatory

Re-running must:
- Converge to the same result
- Never duplicate work
- Never corrupt an existing setup

Idempotence is a product feature, not a best-effort optimization.

### 3. Install ≠ configure ≠ verify

These are separate concerns:
- **Drivers** install software
- **Restorers** apply configuration
- **Verifiers** prove correctness

No step silently assumes success.

### 4. Verification is first-class

"It ran" is not success. Success means the desired state is **observable**.

### 5. Platform-agnostic by design

Windows-first in implementation, platform-agnostic in architecture. Manifests express intent; drivers adapt to the platform.

### 6. Safety before convenience

Defaults are non-destructive. Existing state is backed up before modification. Destructive operations require explicit opt-in.

### 7. Deterministic planning

Before execution, the system can resolve drivers, compute steps, and show exactly what will happen. No hidden work.

### 8. State is remembered

Provisioning records what was intended, applied, skipped, and failed. This enables drift detection and confident re-runs.

### 9. Human trust matters

Logs, plans, and reports are designed for humans. You should be able to read a run and understand it.

---

## Non-Goals

Provisioning is **not**:
- A remote fleet manager
- An always-on agent
- An enterprise MDM replacement
- A replacement for OS installers

It focuses on repeatable personal and small-team machines.

---

## Lifecycle

```
capture → plan → apply → verify → (re-run)
```

| Stage | What happens |
|-------|--------------|
| **capture** | Observe current machine state, emit a manifest |
| **plan** | Compare manifest to current state, compute actions |
| **apply** | Execute actions (install apps, restore configs) |
| **verify** | Confirm desired state is achieved |
| **re-run** | Safe to repeat at any time |

---

## Architecture

```
Manifest → Planner → Drivers/Restorers → Verifiers → State/Reports
```

| Component | Responsibility |
|-----------|----------------|
| **Manifest** | Declarative desired state (apps, configs, verification rules) |
| **Planner** | Resolves manifest, detects drift, computes minimal diff |
| **Drivers** | Install software via package managers (winget) |
| **Restorers** | Apply configuration (copy, merge, append) |
| **Verifiers** | Confirm state (file-exists, command-exists, registry-key-exists) |
| **State** | Persist run history, enable drift detection |

---

## Directory Structure

```
provisioning/
├── README.md              # This file
├── cli.ps1                # CLI entrypoint
├── engine/                # Core logic
│   ├── capture.ps1        # Machine state capture
│   ├── plan.ps1           # Execution planning
│   ├── apply.ps1          # Action execution
│   ├── verify.ps1         # State verification
│   ├── restore.ps1        # Configuration restoration
│   ├── manifest.ps1       # Manifest parsing and includes
│   ├── diff.ps1           # Artifact comparison
│   ├── report.ps1         # Run history reporting
│   ├── state.ps1          # State persistence
│   └── ...
├── drivers/               # Software installation
│   └── winget.ps1         # Windows Package Manager driver
├── restorers/             # Configuration restoration
│   ├── copy.ps1           # File copy with backup
│   ├── append.ps1         # Append to files
│   ├── merge-json.ps1     # JSON merge
│   └── merge-ini.ps1      # INI merge
├── verifiers/             # State verification
│   ├── file-exists.ps1
│   ├── command-exists.ps1
│   └── registry-key-exists.ps1
├── manifests/             # Desired state declarations
│   ├── local/             # Machine-specific (gitignored)
│   ├── examples/          # Shareable examples
│   └── includes/          # Reusable manifest fragments
├── state/                 # Run history and checksums
├── plans/                 # Generated execution plans
├── logs/                  # Execution logs
└── tests/                 # Provisioning-specific tests
```

---

## CLI

### Commands

| Command | Description |
|---------|-------------|
| `capture` | Capture current machine state into a manifest |
| `plan` | Generate execution plan without applying |
| `apply` | Execute the plan (use `-DryRun` to preview) |
| `restore` | Restore configuration files (requires `-EnableRestore`) |
| `verify` | Check current state against manifest |
| `diff` | Compare two plan/run artifacts |
| `report` | Show history of previous runs |
| `doctor` | Diagnose environment issues |

### Examples

```powershell
# Capture current machine state
.\cli.ps1 -Command capture -Profile my-machine

# Generate and review plan
.\cli.ps1 -Command plan -Manifest .\manifests\my-machine.jsonc

# Preview what would be applied
.\cli.ps1 -Command apply -Manifest .\manifests\my-machine.jsonc -DryRun

# Apply for real
.\cli.ps1 -Command apply -Manifest .\manifests\my-machine.jsonc

# Verify current state
.\cli.ps1 -Command verify -Manifest .\manifests\my-machine.jsonc

# Restore configuration files
.\cli.ps1 -Command restore -Manifest .\manifests\my-machine.jsonc -EnableRestore

# Check environment health
.\cli.ps1 -Command doctor

# Show recent runs
.\cli.ps1 -Command report -Last 5
```

---

## Manifest Format

Manifests are authored in **JSONC** (JSON with comments). Supported formats: `.jsonc`, `.json`, `.yaml`, `.yml`

### Basic Structure

```jsonc
{
  "version": 1,
  "name": "my-workstation",

  // Apps to install
  "apps": [
    {
      "id": "git",
      "refs": { "windows": "Git.Git" }
    },
    {
      "id": "vscode",
      "refs": { "windows": "Microsoft.VisualStudioCode" },
      "version": ">=1.80.0"  // Optional version constraint
    }
  ],

  // Configuration to restore (opt-in)
  "restore": [
    { "type": "copy", "source": "./configs/.gitconfig", "target": "~/.gitconfig" }
  ],

  // Verification rules
  "verify": [
    { "type": "file-exists", "path": "~/.gitconfig" }
  ]
}
```

### Modular Manifests

Large manifests can include reusable fragments:

```jsonc
{
  "version": 1,
  "name": "dev-workstation",
  
  "includes": [
    "./includes/dev-tools.jsonc",
    "./includes/media-apps.jsonc"
  ],

  "apps": [
    { "id": "custom-tool", "refs": { "windows": "Custom.Tool" } }
  ]
}
```

**Include rules:**
- Paths resolve relative to the including manifest
- Arrays (`apps`, `restore`, `verify`) are concatenated
- Scalar fields in root manifest take precedence
- Circular includes are detected and rejected

### Version Constraints

| Constraint | Example | Behavior |
|------------|---------|----------|
| Exact | `"1.2.3"` | Installed version must equal `1.2.3` |
| Minimum | `">=1.2.3"` | Installed version must be ≥ `1.2.3` |
| None | (omit) | Any version satisfies |

### Custom Drivers

For software not in winget:

```jsonc
{
  "id": "mytool",
  "driver": "custom",
  "custom": {
    "installScript": "provisioning/installers/mytool.ps1",
    "detect": { "type": "file", "path": "C:\\Program Files\\MyTool\\mytool.exe" }
  }
}
```

Detect types: `file`, `registry`

**Security:** Install scripts must be under repo root; path traversal is blocked.

---

## Drivers

Drivers install software via platform-specific package managers.

| Driver | Platform | Status |
|--------|----------|--------|
| `winget` | Windows | Implemented (default) |
| `custom` | Any | Implemented |
| `apt` | Linux | Planned |
| `brew` | macOS | Planned |

---

## Restorers

Restorers apply configuration files.

| Type | Description |
|------|-------------|
| `copy` | Copy file with optional backup |
| `append` | Append content to file |
| `merge-json` | Deep merge JSON files |
| `merge-ini` | Merge INI files |

Restore operations require explicit opt-in via `-EnableRestore`.

---

## Verifiers

Verifiers confirm desired state is achieved.

| Type | Description |
|------|-------------|
| `file-exists` | Check file exists at path |
| `command-exists` | Check command is available |
| `registry-key-exists` | Check registry key exists |

---

## Safety Defaults

| Default | Behavior |
|---------|----------|
| **Backup before overwrite** | Existing files backed up to `state/backups/` |
| **Non-destructive** | No deletions unless explicitly configured |
| **Dry-run support** | All commands support `-DryRun` |
| **Restore opt-in** | Restore requires `-EnableRestore` flag |
| **Script sandboxing** | Custom scripts must be under repo root |

---

## State and Drift

State is tracked in `state/` and `.autosuite/state.json` (repo root).

**Drift detection** compares current state against a manifest:
- **Missing** — required but not installed
- **Extra** — installed but not in manifest
- **VersionMismatches** — version constraint violations

The `verify` command reports drift:
```
[autosuite] Drift: Missing=2 Extra=5 VersionMismatches=0
```

---

## Current Limitations

- **winget only** — apt/brew drivers not yet implemented
- **Windows-first** — tested primarily on Windows 11
- **Restore opt-in** — configuration restoration requires explicit flag
- **No rollback** — failed operations do not automatically roll back

See [../roadmap.md](../roadmap.md) for planned development.
