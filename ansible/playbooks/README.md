# Settings / Files to use for Ansible playbooks

Linting for YAML / Ansible
---
**disabled:**
  - `role-name` (role name follows regex pattern)
  - `risky-file-permissions` (unspecified file permissions)
  - `line-length` (no lines longer than 80 characters)
  - `no-handler` (don't use handlers) 

**warning:**
  - `risky-shell-pipe` (shell module + using pipes)
  - `no-changed-when`

**pre-commit**
---
- File ending consistency (here: LF by default)
- TOML check
- YAML check
- check added large files
- trailing whitespace
- end of file
- check merge conflict (merge artefacts)
- Ansible lint
