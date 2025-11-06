# Homelab IaC & Automation Sandbox

This repository contains the Infrastructure-as-Code and configuration management for my self-hosted homelab. It is both a learning playground (DevOps, security, automation, reverse engineering) and a daily-use environment (DNS, reverse proxy, Git hosting, backups, future personal services).

## Vision
Build a self-recovering, fully automated, self-hosted platform that:
- Minimizes manual / pet server operations (cattle-first mindset)
- Uses Ansible + OpenTofu (Terraform alternative) + GitLab CI (self-hosted only)
- Leverages Terragrunt for environment orchestration with native SOPS integration
- Secures credentials with SOPS (age) so AI assistants can help safely
- Enforces strong quality gates (lint, formatting, policy, security scan)
- Provides fast rebuild capability in case of disaster or experimentation
- Supports Windows analysis lab (malware / RE) isolated from production services

## Current Stack
- Proxmox: virtualization (QEMU VMs + LXC containers)
- Ansible: configuration (roles for CoreDNS, Traefik, GitLab, FluxCD, Restic, NFS, K3s, etc.)
- OpenTofu: provisioning (Proxmox resources, MinIO, core services)
- Terragrunt: planned introduction to orchestrate Tofu stacks per environment
- CoreDNS: internal DNS
- Traefik: reverse proxy / ingress
- GitLab: internal SCM & CI/CD (GitHub acts only as public mirror/CV. Initial bootstrap: code lives on GitHub and spawns the internal GitLab. After bootstrap, GitLab becomes the source of truth; GitHub remains a read-only showcase.)
- K3s: lightweight Kubernetes (rpi cluster with a master VM)
- Restic: backup jobs (e.g. Windows laptop -> homelab target)
- GitLab Runner: LXC container on Proxmox (Shell executor initially)
- Terragrunt: orchestrates environment stacks with native SOPS decryption

## Operational Mode
- Mode: Build. The repo is moving from planning to active implementation.
- Expect new files, pre-commit hooks, and Terragrunt scaffolding to land.
- All automation will be self-hosted; no reliance on GitHub Actions.

## Near-Term Roadmap (Phased)
1. Pre-commit quality gate (Ansible, Tofu, YAML, secrets, security)
2. Introduce Terragrunt live layout with SOPS-backed inputs
3. GitLab CI pipeline (lint → validate → plan → security → apply manual)
4. GitOps apps via FluxCD (Paperless-NGX, Vaultwarden, Navidrome, etc.)
5. Observability stack (VictoriaMetrics + Loki + Grafana)
6. Backup strategy expansion (restic)
7. Windows malware / RE lab (isolated network segment, forensic tooling)
8. Policy as Code (OPA/Conftest rules for Terraform/K8s manifests)
9. ChatOps & AI Ops (Discord bot triggering non-prod plans; guarded applies)

## Directory Overview
```
ansible/        # Playbooks, roles, inventories, encrypted group/host vars
opentofu/       # OpenTofu stacks (core services, infrastructure, modules)
packer/         # Packer templates (e.g. GitLab image, future Windows templates)
policy/         # (Planned) OPA Rego policies for Terraform/K8s
scripts/        # (Planned) Helper scripts for automation tasks
terragrunt/     # (Planned) Live env orchestration for Tofu modules
```

## Secrets Management
- SOPS + age keys: all sensitive var files use `.sops.yaml` rules.
- Edit encrypted files directly: `sops ansible/group_vars/group_nas/restic.sops.yaml`
- Decrypt temporarily for commands: `sops -d file.sops.yaml | yq '.some.key'`
- Terragrunt: will use `sops_decrypt_file()` to load env-specific secrets.
- Avoid committing any plaintext secrets (pre-commit will block). If a false positive occurs, update the detect-secrets baseline.

## Development Workflow
1. Enter dev shell
   - `nix develop` (flake provides ansible, kubectl, opentofu, tflint, packer, fluxcd, molecule)
   - Add `sops` and `age` to devShell later (or `nix-shell -p sops age` temporarily)
2. Install Python CLIs via uv
   - `uv tool install pre-commit ansible-lint detect-secrets tflint`
3. Run hooks
   - `pre-commit install`
   - `pre-commit run --all-files`
4. Make changes
   - Add or modify role/playbook/module
   - Ensure secrets use `.sops.yaml` patterns (suffix `.sops.yaml`, `.sops.tfvars`)
5. Validate manually
   - Ansible: `ansible-playbook --syntax-check ansible/playbooks/traefik.yml`
   - Tofu: `cd opentofu/infrastructure && tofu init && tofu validate`
   - Terragrunt (when enabled): `cd terragrunt/live/prod && terragrunt run-all plan`
6. Plan locally
   - `tofu plan -var-file=secrets.sops.tfvars -out=infra.plan` (decrypt via `sops -d` pipeline if needed)
7. Apply (guarded)
   - CI/CD will later require manual approval; locally: `tofu apply infra.plan`

## AI Collaboration Guidelines
- Provide context (target component, desired outcome, constraints) before generating code.
- Let AI propose diffs; review with lint + policy before merging.
- Never paste decrypted secret contents into prompts.
- Use generic placeholders (`<password>`, `<token>`) for design flows; fill them in a SOPS file separately.

## Disaster Recovery (High-Level)
1. Reinstall Proxmox / base OS
2. Restore repo from GitLab backup (or local clone)
3. Recreate age key (or import backup) for SOPS
4. OpenTofu apply core infrastructure modules
5. Run Ansible site playbook(s)
6. Bootstrap K3s + FluxCD manifests
7. Restore backups (restic)

A more detailed runbook will live in `docs/recovery.md` (planned).

## Windows Analysis Lab (Planned)
- Packer build: hardened Windows template (Sysmon, Defender config, OSQuery)
- Isolated network segment + fake services (INetSim) for malware detonation
- Snapshot + rollback via Terraform module
- Optional Velociraptor agent for DFIR collection (open-source artifact gathering tool)

## Contributing / Extending
Even as a solo project, treat branches like team collaboration:
- Feature branch → pre-commit passes → Merge Request (GitLab) → pipeline (plan only) → manual apply.
- Keep modules small and composable (Proxmox VM/LXC, service layer, K8s apps).
- Prefer declarative over ad-hoc scripts; where imperative needed, keep it idempotent.

## Status
Build mode: implementing pre-commit hooks and introducing Terragrunt scaffolding; GitLab CI to follow. Internal GitLab is source of truth; GitHub is a read-only showcase.

---
Questions or improvement ideas: open an issue or start a MR in internal GitLab (GitHub mirror is read-only showcase).
