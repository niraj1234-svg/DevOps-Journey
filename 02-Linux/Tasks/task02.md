# Task 02 – File & Directory Permissions

## Objective
Create a directory and file, set Linux permissions, and verify using ls -l.

## Task Requirements
1. Create /devops_workspace.
2. Create project_notes.txt inside it.
3. Set permissions:
   - Owner: Read and Write
   - Group: Read only
   - Others: No access
4. Verify using ls -l.

## Solution

### 1. Create Directory
sudo mkdir -p /devops_workspace

### 2. Set Directory Ownership
sudo chown "$USER":"$USER" /devops_workspace

### 3. Create File
touch /devops_workspace/project_notes.txt

### 4. Set Permissions
chmod 640 /devops_workspace/project_notes.txt

### 5. Permission Breakdown

| Category | Permission | Value |
|----------|------------|-------|
| Owner | Read + Write | 6 |
| Group | Read only | 4 |
| Others | No access | 0 |

Therefore, 640 = rw-r-----

### 6. Verify Permissions
ls -l /devops_workspace/project_notes.txt

Expected output:

-rw-r----- 1 user user ... project_notes.txt

## Important Note

chmod 764 is incorrect for this task.

7 = Read + Write + Execute
6 = Read + Write
4 = Read only

Correct permission: 640

## Verification Checklist
- [ ] Directory created.
- [ ] File created.
- [ ] Permissions set to 640.
- [ ] ls -l output verified.
