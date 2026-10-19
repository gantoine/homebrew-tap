class Muxer < Formula
  desc "Connects the Muxer Android app to cmux on this Mac"
  homepage "https://github.com/gantoine/muxer"
  version "0.7.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/gantoine/muxer/releases/download/0.7.0/muxer-0.7.0-darwin-arm64.tar.gz"
    sha256 "c064d7169ff809f03551d75bdfacc06b8c6967eef9e008535280683c07874503"
  else
    url "https://github.com/gantoine/muxer/releases/download/0.7.0/muxer-0.7.0-darwin-amd64.tar.gz"
    sha256 "eee2ba12bfc8f2997e012ef6802eaa58a283e0e9a1ba34ac8e938a82a1d43374"
  end

  depends_on :macos

  def install
    bin.install "muxer"
  end

  def caveats
    <<~EOS
      Set up the relay:
        muxer install
        tailscale serve --bg --https=8765 http://127.0.0.1:8765   # or another HTTPS proxy, see the README
        muxer doctor
        muxer pair

      After upgrading, run `muxer install` again to restart the relay on the new version.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/muxer version").strip
  end
end
