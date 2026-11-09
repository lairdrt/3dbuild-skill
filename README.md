# 3D Print Collaborator — ChatGPT & Claude

A **chat-first, GitHub-mediated workflow** for designing a functional 3D-printed part collaboratively with ChatGPT or Claude. **OpenSCAD is the local viewer**, not the primary place where family members must write code.

**Preferred loop:** describe or measure a part → assistant edits parametric OpenSCAD source in the project GitHub repository → assistant confirms the commit → user runs `git pull --ff-only` → OpenSCAD automatically previews the updated file → user gives feedback → repeat → verify STL → slice → print.

**Skill:** [3d-print-collaborator/SKILL.md](3d-print-collaborator/SKILL.md)  
**Setup guide:** [3d-print-collaborator/references/setup-and-github.md](3d-print-collaborator/references/setup-and-github.md)  
**Print validation:** [3d-print-collaborator/references/verification-and-print.md](3d-print-collaborator/references/verification-and-print.md)

## Start here

1. Install [OpenSCAD](https://openscad.org/downloads.html), [Git](https://git-scm.com/downloads/), and a slicer (such as [Bambu Studio](https://github.com/bambulab/BambuStudio)); have your own GitHub account.
2. Create a **separate GitHub repository for your part** (not this skill repository) and clone it locally.
3. In **ChatGPT** or **Claude**, connect GitHub and authorize the part repository. **Ask the assistant to test both read and write actions**. Connections differ: some GitHub integrations can only read. See the detailed parallel setup sections in the guide.
4. Load the skill according to the app's supported interface, or attach the skill instructions and references to the chat. Tell the assistant what part you want.
5. Once the assistant has created `src/your-part.scad` on GitHub, open the **local clone** of that file in OpenSCAD and enable **Design → Automatic Reload and Preview**.
6. After each assistant-confirmed commit, use the following in PowerShell from your design repository:

```powershell
git status
git pull --ff-only origin main
```

OpenSCAD should preview the new version. The assistant owns CAD source changes; the person uses OpenSCAD to inspect the evolving design, give feedback, and eventually slice and print. Press F5 if preview doesn't automatically reload.

## ChatGPT and Claude: same workflow

| Chat interface | Connect GitHub | Before depending on remote commits |
| --- | --- | --- |
| **ChatGPT** | Settings → Plugins → GitHub (or relevant enabled GitHub app) | Ask whether `create/update file` or Git commit operations are available; confirm a reversible test commit |
| **Claude** | In chat use **+ → Add from GitHub**; or configure an available GitHub MCP connector | `Add from GitHub` is a repository-context feature; test whether this session has **write-capable GitHub tools**, not just file sync |

If writes aren't available in the selected chat, do not pretend they happened. The setup guide explains how to choose a write-capable connection or use a clearly labeled manual fallback. **Codex and Claude Code are equally valid optional local-agent paths, but neither is required for the preferred chat-first design loop when remote writing is available.**

## Install and share the skill

The [`3d-print-collaborator/`](3d-print-collaborator/) folder contains a portable Agent Skills-style `SKILL.md` plus references and an example.

- **Claude:** With Skills enabled, use **Customize → Skills → + → Create skill → Upload a skill** and provide a ZIP containing the `3d-print-collaborator/` folder as its top-level directory. See [Claude Skills Help](https://support.claude.com/en/articles/12512180-use-skills-in-claude).
- **ChatGPT:** Eligible workspaces use **Plugins → Skills → Create → Upload from your computer**. See [ChatGPT Skills Help](https://help.openai.com/en/articles/20001066-skills-in-chatgpt). Skills availability depends on plan/workspace; a user without native Skills can still attach or paste the instructions in a chat, subject to available GitHub tools.
- **Codex / Claude Code (optional):** Place the skill directory in the relevant agent skill directory for that product; see its current documentation.

To build the installable ZIP from a clone of this repository:

```powershell
Compress-Archive -Path .\3d-print-collaborator -DestinationPath .\3d-print-collaborator.zip -Force
```

The skill includes no credentials. Each family member needs their own GitHub authorization and their own model repository; public access to this **instruction repository** does not automatically give anyone write access to someone else's model repository.

## Engineering principles

Parametric source is the editable design authority. Release STL, slicer 3MF, and printed-part measurements are distinct artifacts. Preserve successful revisions in GitHub; never force-push over somebody else's work. A rendered model or watertight mesh is **not** physical-fit evidence. Use the smallest meaningful print test for uncertain mechanical fits.

### Sources
- [OpenAI — connecting GitHub](https://help.openai.com/en/articles/11145903-connecting-github-to-chatgpt)
- [OpenAI — Skills](https://help.openai.com/en/articles/20001066-skills-in-chatgpt)
- [Claude — GitHub integration](https://support.claude.com/en/articles/10167454-use-the-github-integration)
- [Claude — Skills](https://support.claude.com/en/articles/12512180-use-skills-in-claude)
- [GitHub — GitHub MCP Server](https://github.com/github/github-mcp-server)
