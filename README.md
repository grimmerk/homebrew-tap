# grimmerk/homebrew-tap

Personal Homebrew tap.

## presenterm-osc8

A fork of [presenterm](https://github.com/mfontanini/presenterm) that renders
markdown links as clickable **OSC 8 terminal hyperlinks** — the link's label is
shown and clickable (Cmd/Ctrl+click), with the URL hidden, just like a GitHub
markdown preview. In terminals without OSC 8 support, links fall back to the
usual `label (url)` display, so nothing is lost. Upstream PR:
[mfontanini/presenterm#908](https://github.com/mfontanini/presenterm/pull/908).

It installs as `presenterm-osc8` so it coexists with an official `presenterm`
install.

**Source:** [grimmerk/presenterm](https://github.com/grimmerk/presenterm) ·
[Releases](https://github.com/grimmerk/presenterm/releases)

### Install

**Option A — one-line install via curl (works on any Mac)**

```bash
ARCH=$([ "$(uname -m)" = "arm64" ] && echo aarch64 || echo x86_64) && \
curl -fsSL "https://github.com/grimmerk/presenterm/releases/download/v0.16.1-osc8.1/presenterm-0.16.1-osc8.1-${ARCH}-apple-darwin.tar.gz" | tar xz -C /tmp && \
sudo mv "/tmp/presenterm-0.16.1-osc8.1/presenterm" /usr/local/bin/presenterm-osc8 && \
presenterm-osc8 --version
```

**Option B — Homebrew (one command, but needs Xcode ≥ 26.3, or no full Xcode.app installed)**

```bash
brew install grimmerk/tap/presenterm-osc8
```

> ⚠️ If it fails with `Your Xcode ... is too outdated`, you have an old
> Xcode.app — just use Option A instead.

**Option C — cargo (if you have Rust)**

```bash
cargo install --git https://github.com/grimmerk/presenterm --branch feat/osc8-hyperlinks
```

### Usage

```bash
presenterm-osc8 your-slides.md
```

Links are clickable in OSC 8-capable terminals (iTerm2, kitty, WezTerm, Ghostty,
Alacritty, Windows Terminal, …).

### Screenshots

<!-- Drag screenshots here on GitHub (before: `label (url)` inline / after: clickable label). -->
