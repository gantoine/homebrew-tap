class Muxer < Formula
  desc "Connects the Muxer Android app to cmux on this Mac"
  homepage "https://github.com/gantoine/muxer"
  version "0.5.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/gantoine/muxer/releases/download/0.5.0/muxer-0.5.0-darwin-arm64.tar.gz"
    sha256 "e18a99923eb0a189bf793d8c59ce9285aec08e703e59760cdaab48b95b50237a"
  else
    url "https://github.com/gantoine/muxer/releases/download/0.5.0/muxer-0.5.0-darwin-amd64.tar.gz"
    sha256 "ea669a02a2e096011e083173a0099f5fd2f95e393a662deb1709395e29239ba9"
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
