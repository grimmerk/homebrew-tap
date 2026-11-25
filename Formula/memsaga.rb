class Memsaga < Formula
  desc "Version control and two-way sync for Claude Code's memory, skills, hooks and config, plus other files you choose, in a git repository you own."
  homepage "https://memsaga.grimmer.io"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.6/memsaga-aarch64-apple-darwin.tar.xz"
      sha256 "64cc83bb34ebed1ae136315eb04d2a139ee8341d9dfd9f6f0cc6f3bd2b163ad7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.6/memsaga-x86_64-apple-darwin.tar.xz"
      sha256 "123a5c32ddb468a23194ffb679decf227ba28ccee7d9d3f1eed726c626ed5f03"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.6/memsaga-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3c481db69cae5383773b2c1696bd72f98c8680df37339bada3346c5b577c1de8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/grimmerk/memsaga/releases/download/v0.1.6/memsaga-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f7d96e24982c8cb2644258cb26b517a306823de3b02aeeee82d6525b5a2d01d4"
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
