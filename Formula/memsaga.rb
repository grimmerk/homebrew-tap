class Memsaga < Formula
  desc "Version control and two-way sync for Claude Code's memory, skills, hooks and config, plus other files you choose, in a git repository you own."
  homepage "https://memsaga.grimmer.io"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.4/memsaga-aarch64-apple-darwin.tar.xz"
      sha256 "326bb02dd7594acbaf1176429c22092fd26ac6fb7e004bb4cda8724cc62b9eae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.4/memsaga-x86_64-apple-darwin.tar.xz"
      sha256 "0a51b7e7f4f24756a718a23e30bd39243266fee10958193cb199cd36adeabb52"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.4/memsaga-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "01f23c899b40fd7f734e5d38166dddd576dd3d51af58811dea956b55f49f66cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.4/memsaga-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c7ce076217dfe55656369a346db7e1ebe94677b3bf4cc45341975ad866a4791b"
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
