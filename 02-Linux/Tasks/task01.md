# Task 01 – User & Group Management

## Objective
Learn about Linux users, groups, and permissions.

## Task Requirements
1. Create user `devops_user`.
2. Create group `devops_team`.
3. Add user to the group.
4. Set password.
5. Grant sudo access.
6. Restrict SSH login for selected users.

## Solution (Ubuntu)

### 1. Create Group
```bash
sudo groupadd devops_team
```

Verify:
```bash
getent group devops_team
```

### 2. Create User
```bash
sudo useradd -m devops_user
```

### 3. Add User to Group
```bash
sudo usermod -aG devops_team devops_user
```

Verify:
```bash
id devops_user
```

### 4. Set Password
```bash
sudo passwd devops_user
```

### 5. Grant Sudo Access
```bash
sudo usermod -aG sudo devops_user
```

Verify:
```bash
groups devops_user
```

Note: Ubuntu uses the `sudo` group. RHEL-based systems commonly use the `wheel` group.

### 6. Restrict SSH Login

Open SSH configuration:
```bash
sudo vim /etc/ssh/sshd_config
```

Add:
```text
DenyUsers devops_user
```

Validate configuration:
```bash
sudo sshd -t
```

If validation succeeds, reload SSH:
```bash
sudo systemctl reload ssh
```

**Warning:** Keep your existing SSH session open while changing SSH configuration. Denying this user will block their SSH login.

## Important Files

| File | Purpose |
|---|---|
| `/etc/passwd` | User account information |
| `/etc/group` | Group information |
| `/etc/shadow` | Protected password information |
| `/etc/ssh/sshd_config` | SSH server configuration |

## Important Corrections
- Use `groupadd devops_team` to create the group.
- `-g` specifies a numeric GID.
- Use `usermod -aG group user` to add a user to a supplementary group.
- On Ubuntu, use `usermod -aG sudo devops_user`.
- Use `vim` to edit files; `cd` cannot open a file.

## Verification Checklist
- [ ] Group created.
- [ ] User created with home directory.
- [ ] User added to `devops_team`.
- [ ] Password set.
- [ ] Sudo access granted.
- [ ] SSH configuration validated.

