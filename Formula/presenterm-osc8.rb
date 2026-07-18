class PresentermOsc8 < Formula
  desc "Terminal markdown presentation tool (fork with clickable OSC 8 hyperlinks)"
  homepage "https://github.com/grimmerk/presenterm"
  version "0.16.1-osc8.1"
  license "BSD-2-Clause"

  depends_on :macos

  on_arm do
    url "https://github.com/grimmerk/presenterm/releases/download/v0.16.1-osc8.1/presenterm-0.16.1-osc8.1-aarch64-apple-darwin.tar.gz"
    sha256 "42d8822945e76722e4ce677c5ad31c3a261bfe6dea5f2d4e418b0e8c6d849a56"
  end

  on_intel do
    url "https://github.com/grimmerk/presenterm/releases/download/v0.16.1-osc8.1/presenterm-0.16.1-osc8.1-x86_64-apple-darwin.tar.gz"
    sha256 "7f04507afa749563ee044079c055156d442b095b8b774b1be2a91be912f85a38"
  end

  # Installed as `presenterm-osc8` so it coexists with the official `presenterm` formula.
  def install
    bin.install "presenterm" => "presenterm-osc8"
  end

  test do
    assert_match "presenterm", shell_output("#{bin}/presenterm-osc8 --version")
  end
end
