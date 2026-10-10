# OpenCode Agent Guide for .dotfiles Repository

This repository is a collection of configuration files (dotfiles) for a customized Linux desktop environment, not a traditional codebase.

## ⚠️ General Workflow Quirks
*   **Operational Knowledge:** Most behavioral and workflow knowledge (e.g., keybindings, window rules, system behavior) is stored in configuration files (e.g., `hypr/hyprland.conf`, `nvim/init.lua`). Consult these files first.
*   **Focus:** Tasks generally involve editing, patching, or generating configuration snippets rather than implementing application logic.

## 📦 Deployment Mechanism (dotter)
*   Files are deployed to their real locations by **dotter** (SuperCuber/dotter), not by manual copying.
*   `.dotter/global.toml` is the source of truth for which repo path maps to which destination (e.g. `hypr` → `~/.config/hypr`) and defines inter-package `depends` ordering. Read it before reorganizing directories or adding new config areas.
*   `.dotter/local.toml` is **machine-specific, gitignored, and contains a secret** (`context7_key`). Never commit, echo, or copy it into tracked files. `.dotter/local.toml-sample` is the committed template.
*   The `dotter` binary is gitignored. Obtain it with `utils/download_dotter`, then run `./dotter`.
*   `.dotter/pre_deploy.sh` (installs mise, oh-my-zsh, tmux tpm, rustup, brew bundle) and `.dotter/post_deploy.sh` run around deployment; they contain `#{{...}}` dotter template hooks.

## 🛠️ Key Configuration Areas

### Window Managers
*   **Hyprland:** Primary window manager configuration at `hypr/hyprland.conf`. Window rules, keybinds, and startup scripts defined here.
*   **Niri:** Scrollable-tiling Wayland compositor config at `niri/config.kdl`.
*   **Sway:** i3-compatible Wayland compositor config at `sway/config`.

### Terminals
*   **Ghostty:** Terminal emulator config at `ghostty/config`.
*   **WezTerm:** Terminal emulator config at `wezterm.lua`.
*   **Alacritty:** Terminal emulator config at `alacritty`.
*   **Kitty:** Terminal emulator config at `kitty/`.

### Editor & IDE
*   **Neovim:** Editor customizations in `nvim/lua/`. Plugins defined in `nvim/lua/plugins.lua`.

### Desktop Environment
*   **Fuzzel:** Application launcher config at `fuzzel/fuzzel.ini`.
*   **Gammastep:** Screen color temperature manager at `gammastep`.
*   **XDG Desktop Portal:** Portal configuration in `xdg-desktop-portal/`.

### Shell & Terminal Tools
*   **Zsh:** Shell configuration split across `zshenv`, `zshrc`, and `zprofile`.
*   **Tmux:** Terminal multiplexer config at `tmux`.

### System
*   **Systemd User:** User services and units in `systemd-user/`.
*   **Utils:** Helper scripts in `utils/`.

## ⚡ Essential Developer Commands
*   **Configuration Updates:** Use `edit` on specific `.conf`, `.kdl`, or `.lua` files to apply changes.
*   **Search:** Use `glob` and `grep` heavily to locate specific configuration patterns or settings across many files.
*   **Validation:** No CI, test suite, linter, or formatter exists. Validation means checking config syntax (TOML, Lua, etc.); the user's machine is effectively the test environment.
*   **OpenSpec:** This repo uses OpenSpec (`openspec/` + `openspec/config.yaml`, spec-driven schema) with `opsx-*` commands/skills in `.opencode/`. Use them for spec-driven change workflows.
