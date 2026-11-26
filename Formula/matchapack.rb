class Matchapack < Formula
  desc "Makes npm ci, npm install and Yarn 1 place node_modules as copy-on-write clones, so each extra checkout or git worktree costs almost no disk"
  homepage "https://github.com/grimmerk/matchapack"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.2/matchapack-aarch64-apple-darwin.tar.xz"
      sha256 "3cd62359b3fcb96be713ab46ebfd9126c006576826bc48a9939397251ce902c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.2/matchapack-x86_64-apple-darwin.tar.xz"
      sha256 "42409a37fe6dd4ce4b158fe0c689d9df73e2b0783f9a8e3da7e5e75c5c444e12"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.2/matchapack-aarch64-unknown-linux-musl.tar.xz"
      sha256 "e0725646f442971b12b9a69a78f9e8b0cc9613333a6b1491ef90eb1fe90d71fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.2/matchapack-x86_64-unknown-linux-musl.tar.xz"
      sha256 "1fd09a37de91bdce1ad5b15ab56e738923de3d178ce9016a82a1ec64b53bb15f"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "matchapack"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "matchapack"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "matchapack"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "matchapack"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
