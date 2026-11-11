class Memsaga < Formula
  desc "Version control and two-way sync for Claude Code's memory, skills, hooks and config, plus other files you choose, in a git repository you own."
  homepage "https://memsaga.grimmer.io"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.5/memsaga-aarch64-apple-darwin.tar.xz"
      sha256 "abf3d33f67dbc62a16b0f0771746f25a7ffb23a3924055f762c87f8be734622f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.5/memsaga-x86_64-apple-darwin.tar.xz"
      sha256 "1b5c20456ccc478382211839ae5d8c86d23530bbfccc5036a4e748263ff5e2af"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.5/memsaga-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d84db00a1e75af56be3fbf52ddeaa40e1f43f713775fb87e3a4f77a6c77d4cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.5/memsaga-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "89e29962377f87e17084cd9ddf5e44a7a494dead59ad97e5c0a7c80c258bcf97"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "memsaga"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "memsaga"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "memsaga"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "memsaga"
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
