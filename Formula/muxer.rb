class Muxer < Formula
  desc "Connects the Muxer Android app to cmux on this Mac"
  homepage "https://github.com/gantoine/muxer"
  version "0.6.1"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/gantoine/muxer/releases/download/0.6.1/muxer-0.6.1-darwin-arm64.tar.gz"
    sha256 "553c2cba7d4a558a4d175bafafbb74deb1e2d0397f9fe08266bcbdc09ba02b02"
  else
    url "https://github.com/gantoine/muxer/releases/download/0.6.1/muxer-0.6.1-darwin-amd64.tar.gz"
    sha256 "af83da8e88c10cb221c5ba45a8607345874a022c9718587f0c93712f6765caf1"
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
