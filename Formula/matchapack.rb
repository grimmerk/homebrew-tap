class Matchapack < Formula
  desc "Makes npm ci, npm install and Yarn 1 place node_modules as copy-on-write clones, so each extra checkout or git worktree costs almost no disk"
  homepage "https://github.com/grimmerk/matchapack"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.0/matchapack-aarch64-apple-darwin.tar.xz"
      sha256 "937cfa07672db0ec11f09782cb6509918115745ba83223caebc6df20eec697a9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.0/matchapack-x86_64-apple-darwin.tar.xz"
      sha256 "403a530856b144d1dfee2fa85afeea328ca753307478dd6725145678894bdb20"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.0/matchapack-aarch64-unknown-linux-musl.tar.xz"
      sha256 "9baee771b13c2643f4c489453680791d09d39488f04e68144183612fa8c011e3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.0/matchapack-x86_64-unknown-linux-musl.tar.xz"
      sha256 "95268aa15b65b3ed883c8316a7c205ba84db89c2a5b17d7356b2285508937fb1"
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
