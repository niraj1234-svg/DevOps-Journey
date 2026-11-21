
# Git & GitHub — Complete Learning Notes

## 1. Version Control and SCM

Version Control is a system that records changes made to files over time.

It helps developers:
- Track changes in source code.
- Maintain commit history.
- Restore previous versions.
- Collaborate with other developers.
- Manage code efficiently.

### What is SCM?

SCM (Source Code Management) is the process of managing and tracking changes in source code.

In DevOps, SCM is important because it helps manage code changes before building, testing, and deploying applications through CI/CD pipelines.

## 2. CVCS vs DVCS

### CVCS (Centralized Version Control System)

- Uses a central server to maintain repository history.
- Developers depend on the central server for many operations.
- Server unavailability can interrupt collaboration.
- Examples: SVN and CVS.

### DVCS (Distributed Version Control System)

- Every developer can have a complete local copy of the repository and its history.
- Developers can commit changes locally.
- Many Git operations work without an internet connection.
- Git is a Distributed Version Control System.

| CVCS | DVCS |
|---|---|
| Central server-based | Distributed architecture |
| More dependent on server | Supports local operations |
| Limited offline operations | Supports offline commits |
| Example: SVN | Example: Git |

## 3. Git vs GitHub

### Git
Git is a Distributed Version Control System used to track changes in source code, maintain commit history, and manage branches.

### GitHub
GitHub is a cloud-based platform that hosts Git repositories and provides collaboration features.

Features:
- Repository hosting
- Pull Requests
- Code Reviews
- Issues
- Team Collaboration
- GitHub Actions

**Remember:** Git is a version control tool, whereas GitHub is a platform for hosting and collaborating on Git repositories.

## 4. Git's Three Main Areas

Git has three main areas:

1. Working Directory
2. Staging Area
3. Git Repository

### Working Directory
The location where developers create, modify, and delete project files.

### Staging Area
The area where we select changes that we want to include in the next commit.

### Git Repository
Stores committed changes and project history.

### Git Workflow

Working Directory → Staging Area → Git Repository

- `git add` moves selected changes to the staging area.
- `git commit` saves staged changes in repository history.

### File Status

- Untracked: Git is not tracking the new file.
- Modified: A tracked file has been changed.
- Staged: Changes are ready for the next commit.
- Committed: Changes have been saved in repository history.

**Note:** Untracked, modified, and staged are file statuses, not the three Git areas.

## 5. Basic Git Commands

### Check Git Version

```bash
git --version
```

### Initialize Repository

```bash
git init
```

### Clone Repository

```bash
git clone <repository-url>
```

### Check Repository Status

```bash
git status
```

### Add Files

```bash
git add filename
git add .
```

### Commit Changes

```bash
git commit -m "Initial commit"
```

### View Commit History

```bash
git log
git log --oneline
```

### View Changes

```bash
git diff
```

### Configure Git Identity

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --list
```

## 6. Git Branching

A branch is an independent line of development.

Branches allow developers to work on different features or bug fixes without directly modifying the main development branch.

### List Branches

```bash
git branch
```

### Create a Branch

```bash
git branch feature
```

### Switch Branch

```bash
git switch feature
```

### Create and Switch Branch

```bash
git switch -c feature
```

Older commands:

```bash
git checkout feature
git checkout -b feature
```

### Difference

- `git branch`: Lists branches when used without arguments; creates a branch when given a branch name.
- `git checkout -b`: Creates a new branch and switches to it.
- `git switch -c`: Modern alternative to create and switch.

## 7. Git Merge

Git Merge is the process of integrating changes from one branch into another branch.

Example:

```bash
git switch main
git merge feature
```

### Merge Conflict

A merge conflict occurs when Git cannot automatically combine changes from two branches.

Example:

Developer 1 changes:

```bash
echo "Welcome Niraj"
```

Developer 2 changes:

```bash
echo "Welcome Raj"
```

If both developers modify the same line differently, Git may generate a merge conflict.

### Conflict Markers

```text
<<<<<<< HEAD
echo "Welcome Niraj"
=======
echo "Welcome Raj"
>>>>>>> feature
```

### How to Resolve Merge Conflict

1. Check conflicted files:

```bash
git status
```

2. Inspect changes:

```bash
git diff
```

3. Open the conflicted file.
4. Decide which changes to keep or combine.
5. Remove conflict markers.
6. Save the file.
7. Stage the resolved file:

```bash
git add filename
```

8. Complete the merge if required:

```bash
git commit
```

## 8. Git Fetch vs Git Pull

### Git Fetch

`git fetch` downloads the latest changes from a remote repository and updates remote-tracking branches.

It does not automatically merge those changes into the current local branch.

```bash
git fetch origin
```

To inspect incoming commits:

```bash
git log HEAD..origin/main --oneline
```

### Git Pull

`git pull` fetches remote changes and integrates them into the current branch, usually through a merge.

Depending on configuration, it can also use rebase.

```bash
git pull origin main
```

### Difference

| Git Fetch | Git Pull |
|---|---|
| Downloads remote changes | Downloads and integrates changes |
| Does not automatically merge | Usually merges changes |
| Allows inspection before integration | Integrates into current branch |

**Remember:**
- Fetch = Download changes.
- Pull = Fetch + Integrate.

## 9. Git Stash

Git Stash is used to temporarily save uncommitted changes without creating a commit.

Example:

You are working on a feature branch, but suddenly you need to fix an urgent bug on another branch.

You can temporarily save your changes using:

```bash
git stash
```

### View Stash List

```bash
git stash list
```

### Apply Stash

```bash
git stash apply
```

Restores changes but keeps the stash entry.

### Pop Stash

```bash
git stash pop
```

Restores changes and removes the stash entry if applying succeeds.

### Drop Stash

```bash
git stash drop
```

Deletes a stash entry without applying it.

| Command | Purpose |
|---|---|
| git stash apply | Apply changes, keep stash entry |
| git stash pop | Apply changes, remove entry if successful |
| git stash drop | Delete stash entry |

## 10. Git Merge vs Git Rebase

### Git Merge

Git Merge integrates changes from one branch into another while generally preserving branch history.

```bash
git switch main
git merge feature
```

### Git Rebase

Git Rebase replays commits of one branch on top of another branch.

It helps create a cleaner and more linear commit history.

```bash
git switch feature
git rebase main
```

### Difference

| Git Merge | Git Rebase |
|---|---|
| Integrates branch histories | Replays commits on a new base |
| Preserves branch structure | Creates a linear history in many cases |
| May create merge commit | Replayed commits get new IDs |

**Important:** Avoid rebasing shared commits unless your team agrees to it, because rebase rewrites commit history.

## 11. Git Cherry-pick

Git Cherry-pick is used to apply a specific commit from another branch to the current branch using its commit ID.

Example:

```bash
git switch main
git cherry-pick <commit-id>
```

It is useful when we need only a particular bug fix or feature instead of merging the entire branch.

**Note:** Cherry-pick does not push changes to GitHub. Push separately if required.

```bash
git push origin main
```

## 12. GitHub Pull Requests

A Pull Request (PR) is a GitHub feature used to propose changes from one branch to another.

### Pull Request Workflow

1. Create a feature branch.
2. Make code changes.
3. Commit changes.
4. Push the branch to GitHub.
5. Create a Pull Request.
6. Team members review the code.
7. Make requested changes.
8. Merge the Pull Request.

Pull Requests help teams review code, discuss changes, and collaborate.

**Note:** A Pull Request is different from the `git pull` command.

## 13. GitHub Actions and CI/CD

GitHub Actions is an automation platform provided by GitHub.

It helps automate:
- Testing
- Building
- Deployment
- CI/CD workflows

### Important Terms

**Workflow:** An automated process defined in a YAML file.

**Event/Trigger:** An event that starts a workflow, such as push or pull_request.

**Job:** A group of steps that runs on a runner.

**Step:** An individual task or command inside a job.

**Runner:** The machine that executes workflow jobs. It can be GitHub-hosted or self-hosted.

### Example GitHub Actions Workflow

Create:

`.github/workflows/ci.yml`

```yaml
name: Node.js CI

on: [push]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

### Workflow Explanation

1. Developer pushes code to GitHub.
2. GitHub Actions detects the push event.
3. Workflow starts.
4. Runner executes the job.
5. Code is checked out.
6. Dependencies are installed.
7. Tests are executed.

A deployment job can also be added to automate delivery or deployment.

## 14. Quick Interview Revision

1. What is SCM?
   - A system or practice used to manage and track source-code changes.

2. CVCS vs DVCS?
   - CVCS uses a central server, while DVCS gives each clone repository history.

3. Git vs GitHub?
   - Git is a version-control system; GitHub hosts Git repositories.

4. What are Git's three main areas?
   - Working Directory, Staging Area, Git Repository.

5. What does git add do?
   - Stages selected changes.

6. What does git commit do?
   - Records staged changes in repository history.

7. What is a Git Branch?
   - An independent line of development.

8. What is a Merge Conflict?
   - When Git cannot automatically combine changes.

9. Fetch vs Pull?
   - Fetch downloads changes; Pull downloads and integrates them.

10. Stash apply vs pop?
    - Apply keeps the stash entry; pop removes it after successful application.

11. Merge vs Rebase?
    - Merge integrates histories; Rebase replays commits on a new base.

12. What is Cherry-pick?
    - Applies a specific commit to the current branch.

13. What is a Pull Request?
    - A proposal to merge changes with code review.

14. What is GitHub Actions?
    - GitHub's platform for automating workflows like testing, building, and deployment.

## 15. Daily Git Workflow Cheat Sheet

```bash
# Check current status
git status

# Create and switch to a feature branch
git switch -c feature/my-work

# Stage changes
git add .

# Commit changes
git commit -m "Add my changes"

# Fetch remote updates
git fetch origin

# Push current branch
git push -u origin feature/my-work

# Switch to main
git switch main

# Update local main
git pull origin main

# Merge feature branch
git merge feature/my-work

# View commit history
git log --oneline --graph --all
```

**Best Practice:** Always check `git status` before committing, merging, or switching branches. Confirm which branch you are working on and which changes are staged.

## 16. Key Learning Takeaway

Git helps manage code history and collaboration. GitHub provides repository hosting and collaboration features. Advanced Git commands like stash, rebase, merge, and cherry-pick help manage development workflows.

GitHub Actions adds automation for CI/CD.

**Learning Sequence:**

Understand the concept → Practice the command → Inspect the result → Explain it in your own words.

---

**DevOps Journey | Git & GitHub**

