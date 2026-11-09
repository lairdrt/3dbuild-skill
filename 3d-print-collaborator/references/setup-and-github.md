# Setup — ChatGPT/Claude chat, GitHub, and OpenSCAD viewer

This is a **chat-first** process. The assistant edits the remote model project; the user watches its evolution in locally installed OpenSCAD after pulling each GitHub commit. **Codex and Claude Code are optional alternatives**, not prerequisites.

Each family member uses their own GitHub account and **their own model repository**. The skill repository is shared instructions, not a common design workspace.

## 1. Install tools (Windows examples)

| Tool | Purpose | Official download |
| --- | --- | --- |
| OpenSCAD | **Viewer** of evolving source; final STL export if needed | https://openscad.org/downloads.html |
| Git | Clone and pull assistant-authored revisions | https://git-scm.com/downloads/ |
| GitHub account | Holds the project and provides authorized remote access | https://github.com |
| Slicer | Preview actual toolpaths and prepare the printer job | [Bambu Studio](https://github.com/bambulab/BambuStudio), OrcaSlicer, PrusaSlicer, or the printer maker's slicer |
| VS Code (optional) | Inspect source/diffs; not required for the viewer workflow | https://code.visualstudio.com |

Windows PowerShell with `winget` (or use official installers):

```powershell
winget install --id OpenSCAD.OpenSCAD -e
winget install --id Git.Git -e
git --version
```

Use macOS/Linux official downloads or package managers as appropriate. OpenSCAD GUI does not require its command line executable on PATH. You do **not** need to write OpenSCAD code by hand.

## 2. Create a new GitHub repository for your part

1. On GitHub, create a new **model repository** (e.g. `lairdrt/cable-guide` would be an example only). Choose Public or Private deliberately; for family projects Private may be preferable. Start with a README so the repo has an initial commit.
2. In GitHub, click **Code → HTTPS** and copy the **actual** repository clone URL.
3. In PowerShell, use your own URL (the following is an example):

```powershell
mkdir "$HOME\Documents\Projects" -Force
cd "$HOME\Documents\Projects"
git clone https://github.com/YOUR-USER/YOUR-PART.git
cd YOUR-PART
git status
```

GitHub authentication is handled by Git's credential manager or the system/browser sign-in. Don't paste access tokens into a chat.

## 3A. ChatGPT — GitHub connection and remote-write qualification

1. In ChatGPT, go to **Settings → Plugins**, find the **GitHub** plugin/app and connect your account; where prompted on GitHub, install/authorize the GitHub app for the **new model repository**. If you already authorized GitHub, edit the repository selection to include the new one.
2. In a **chat** with this skill loaded, give ChatGPT the repository owner and name and ask it to fetch the README and branch HEAD.
3. Ask the assistant: **“Identify the available GitHub file-create/update and commit actions in this session. Can you write into my selected repo? Do not assume a connected GitHub reader means you can write.”**
4. If the write tools are present and you approve, let it create a **disposable small file or initial `src/part.scad`**, then **verify the commit SHA** and its file in GitHub. The user can delete a disposable file through an ordinary follow-up commit if desired.
5. Some GitHub connections/modes expose read-only context, while some configured GitHub plugins provide **write actions**. The product name alone is not proof of write access. If this specific session lacks it, review which supported GitHub app/plugin tools or authorized workflows are available; do not insist on a coding agent when a write-capable chat connection is available.

OpenAI references: [GitHub in ChatGPT](https://help.openai.com/en/articles/11145903-connecting-github-to-chatgpt), [GitHub plugin](https://openai.com/business/plugins/github/).

## 3B. Claude — GitHub connection and remote-write qualification

1. In Claude chat, use the **+ → Add from GitHub** flow to connect the GitHub account and select the model repository/files for context. Within a Claude Project, repository content can be added and refreshed with its sync control.
2. **Distinguish repository context from GitHub write tools.** Claude's built-in `Add from GitHub` help describes selecting and syncing files; it does not by itself prove that the active chat can create commits.
3. If you have a supported **GitHub MCP connector**, configure it using Claude's connector/settings flow, authorize access to the chosen repository, and ensure it actually exposes **file-create/update and commit** actions. GitHub publishes an [official GitHub MCP Server](https://github.com/github/github-mcp-server) with read/write operations, but its permissions and tool availability depend on how it is installed and authenticated.
4. In the Claude session ask: **“Which GitHub tools can you invoke right now? Verify read and file-write/commit capability in OWNER/REPO. Do not make a change until I approve a reversible test.”** If the tools are available, authorize a small test commit; verify the file and commit SHA.
5. If your account has only the read/sync integration, don't treat it as a failure of this skill. Choose a supported write-capable Claude connector/session if available, or use the manual fallback below.

Anthropic references: [Use the GitHub integration](https://support.claude.com/en/articles/10167454-use-the-github-integration), [Use connectors](https://support.claude.com/en/articles/11176164-use-connectors-to-extend-claude-s-capabilities). GitHub references: [Official MCP Server](https://github.com/github/github-mcp-server). **Never paste tokens in chat or add them to the repository.**

## 4. Install the skill in your chat product

### ChatGPT

When your plan/workspace supports Skills: **Plugins → Skills → Create → Upload from your computer**, and select a ZIP whose root folder is `3d-print-collaborator/`. The uploaded skill is available only as permitted by the workspace; merely being able to read a public GitHub repository doesn't install the skill. If native Skills aren't available, provide the `SKILL.md` text and relevant references to the conversation or project and ask the assistant to use them. This is a prompt/instruction fallback, **not** an installed skill.

Official: https://help.openai.com/en/articles/20001066-skills-in-chatgpt

### Claude

Enable code execution and Skills as required by your account. Use **Customize → Skills → + → Create skill → Upload a skill** and select a ZIP containing the `3d-print-collaborator/` directory. Enable the imported skill. Alternatively, attach the `SKILL.md` and references as project instructions where appropriate. Skills do not themselves confer GitHub write permission.

Official: https://support.claude.com/en/articles/12512180-use-skills-in-claude

### Shared first prompt for either chat

> Use the 3D Print Collaborator skill. Help me design a [describe part] in OpenSCAD. Commit each validated design revision to my authorized GitHub repo OWNER/REPO. I will view the pulled `.scad` file in OpenSCAD with Automatic Reload and Preview turned on. Ask me only for missing critical dimensions, and preserve known-good versions.

## 5. OpenSCAD as a live **viewer** of GitHub versions

After the assistant has created and committed `src/<part>.scad`:

1. Open **that file from your local clone** using OpenSCAD **File → Open**; not a download or a stale copy.
2. Enable **Design → Automatic Reload and Preview**. Leave the OpenSCAD window open.
3. After the assistant says that the new source revision is committed and gives its SHA, run the following from the model repo:

```powershell
git status
git pull --ff-only origin main
```

4. The OpenSCAD preview normally updates as the file changes on disk; press **F5** for preview and **F6** for final render when desired. If the repository uses a branch other than `main`, use the correct branch. **Git pull is the synchronization step**; simply committing on GitHub does not instantly change a local file.
5. Tell the assistant what looks correct or incorrect. Provide measurements or a screenshot when needed. The assistant updates the source and the loop repeats.

**Viewer boundary:** ChatGPT/Claude chat cannot see the OpenSCAD window or silently edit the PC just because GitHub is connected. The assistant works through the approved remote repository; the user controls when to pull and whether to print.

OpenSCAD manual: https://files.openscad.org/documentation/manual/Using_an_external_Editor_with_OpenSCAD.html

## 6. Optional local agents — Codex **and** Claude Code

Codex and Claude Code have parallel *optional* local-repository execution workflows. Either can edit `src/<part>.scad` **directly in the local clone** when authorized, causing OpenSCAD auto-reload without any `git pull`. In those sessions the agent should commit/push validated milestones to GitHub so progress is not lost.

That workflow is not the default family procedure: **the priority remains ordinary ChatGPT or Claude conversations with GitHub as the editing bridge and OpenSCAD as viewer**.

## 7. When remote GitHub writing isn't available

Do not silently pivot to local coding agents or pretend a remote commit happened. The chat assistant should produce a **complete** OpenSCAD file plus a short explanation. The user can save it in `src/` and deliberately run:

```powershell
git add src/
git commit -m "Add parametric CAD model"
git push origin main
```

This is a *fallback* only. When remote commit actions are available, the assistant should perform them rather than make users copy/paste files.

## 8. Git safety

- `git pull --ff-only` is safe when the user has no conflicting local changes; inspect `git status` first.
- If pull fails due to divergence, inspect the histories and stop for an explicit reconciliation plan. Never use destructive resets or force pushes by default.
- If a user manually edits/commits locally, tell the assistant so remote changes don't overwrite their work.
- At a successful physical-fit milestone, commit/tag matching parametric source, STL and print-profile files. Keep exploratory branches/releases separate from a known-good baseline.
