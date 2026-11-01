class Memsaga < Formula
  desc "Version control and two-way sync for Claude Code's memory, skills, hooks and config, plus other files you choose, in a git repository you own."
  homepage "https://memsaga.grimmer.io"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.3/memsaga-aarch64-apple-darwin.tar.xz"
      sha256 "a91eb829584c3d1057a6996463344297fceb7f5beadb5dc8be83293280ad0697"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.3/memsaga-x86_64-apple-darwin.tar.xz"
      sha256 "c87ac33b7cee85d6e5099aaba6c3f266a14f35ee15e942b0286e80bda541a9b6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.3/memsaga-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cfe93c0070ad45e62f1bd82b428b3dd0829bc04d1426f81d312a674c97626588"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.3/memsaga-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "555c680c25f695bbb8a23e03d01440d0094e665429896e6489e107d930e5965e"
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
