# pilab

Raspberry Pi configuration for my homelab

## Setup

### Doppler

This project uses [Doppler](https://www.doppler.com/) for secrets management.

1. Login to Doppler:

   ```bash
   doppler login
   ```

2. The project is configured via `doppler.yaml` to use:

   - Project: `pilab`
   - Config: `dev_personal`

3. Run commands with Doppler:
   ```bash
   cd deploy
   task run  # Uses doppler run internally
   ```

## Deployment

Deploy changes to the Pi server using Ansible:

```bash
cd deploy
task run
```

Pass ansible-playbook arguments after `--`:

```bash
# Dry run (check mode)
task run -- --check

# Verbose output
task run -- -vvv

# Combine multiple arguments
task run -- --check --diff
```
