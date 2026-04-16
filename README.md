# dot-ai

Personal backup for my agentic coding setup.

This repo stores the config for:

- Claude Code (`~/.claude`)
- OpenCode (`~/.opencode`)

Everything is versioned with Git so I can sync my setup across machines like dotfiles. [web:34][web:39]

---

## Structure

```text
$HOME/dot-ai
├── .claude/       # mirror of ~/.claude
├── opencode/      # mirror of ~/.opencode
├── backup.sh      # one-shot backup script
└── restore.sh     # one-shot restore script
```

---

## First-time setup (local)

1. Create the repo directory:

```bash
mkdir -p ~/dot-ai
cd ~/dot-ai
git init
git checkout -b main
```

2. Add the scripts (copy `backup.sh` and `restore.sh` into `~/dot-ai`) and make them executable:

```bash
chmod +x ~/dot-ai/backup.sh
chmod +x ~/dot-ai/restore.sh
```

3. Run an initial backup:

```bash
~/dot-ai/backup.sh
```

4. Commit the initial state:

```bash
git add .
git commit -m "chore: initial Claude + OpenCode backup"
```

---

## Connecting to GitHub (or any remote)

1. Create a **private** repo called `dot-ai` on GitHub / GitLab. [web:34][web:38]

2. Add it as a remote and push:

```bash
cd ~/dot-ai
git remote add origin git@github.com:<your-username>/dot-ai.git
git push -u origin main
```

Now this repo acts as your cloud backup and source of truth. [web:34][web:38]

---

## Backing up configs (daily use)

Whenever you tweak Claude Code or OpenCode settings, skills, or agents:

```bash
~/dot-ai/backup.sh
git push
```

The script:

- Copies `~/.claude` into `~/dot-ai/.claude/`
- Copies `~/.opencode` into `~/dot-ai/opencode/`
- Commits any changes with a standard message

---

## Restoring on a new machine

On a fresh machine:

```bash
git clone git@github.com:<your-username>/dot-ai.git ~/dot-ai
cd ~/dot-ai
./restore.sh
```

The script:

- Pulls latest changes
- Restores `.claude/` → `~/.claude`
- Restores `opencode/` → `~/.opencode`

Then restart your editor / agents and you should have the same setup.

---

## Security notes

- Keep this repo **private**; your agent configs may contain paths, history, or sensitive context. [web:38]
- Do **not** store API keys or secrets directly in these folders.
  - Prefer `.env` files, OS keychains, or a separate secrets manager.
- If you must store any config with tokens, add them to `.gitignore` before committing. [web:38]

---

## Extending later

You can later add more agent configs:

- Add `cursor/`, `aider/`, etc. directories
- Update `backup.sh` and `restore.sh` to sync those folders too

This keeps all your agentic coding tools under one versioned umbrella.
