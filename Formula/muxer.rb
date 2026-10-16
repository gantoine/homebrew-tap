class Muxer < Formula
  desc "Connects the Muxer Android app to cmux on this Mac"
  homepage "https://github.com/gantoine/muxer"
  version "0.4.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/gantoine/muxer/releases/download/0.4.0/muxer-0.4.0-darwin-arm64.tar.gz"
    sha256 "1fde10e728982f604b776df722197b38e5a045b39676fba462b697dcf9d829d2"
  else
    url "https://github.com/gantoine/muxer/releases/download/0.4.0/muxer-0.4.0-darwin-amd64.tar.gz"
    sha256 "b03b2a2e0742dd343ac7982814834e286830bb2b8602cd7e078863a92cc8c0ee"
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
