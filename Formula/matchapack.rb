class Matchapack < Formula
  desc "Makes npm ci, npm install and Yarn 1 place node_modules as copy-on-write clones, so each extra checkout or git worktree costs almost no disk"
  homepage "https://github.com/grimmerk/matchapack"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.1/matchapack-aarch64-apple-darwin.tar.xz"
      sha256 "823867932bcae2a167531cf521ab52a91737fb5b5f8edcf8999f15eb152d5899"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.1/matchapack-x86_64-apple-darwin.tar.xz"
      sha256 "1fe7b6f64be0f2bbf35c7aa8c573e74bdbca6b781550c13bfbb2d1cd7c91d78a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.1/matchapack-aarch64-unknown-linux-musl.tar.xz"
      sha256 "3ee36a4d196292a3d448fc4d0148c3d56249015f548e1ddcf870e3f3c6e76028"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/matchapack/releases/download/v0.1.1/matchapack-x86_64-unknown-linux-musl.tar.xz"
      sha256 "b7e6841aaddd9c34e909e4d7b4f01fc667e5c3d554d6fd51f716bdca917e730e"
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
