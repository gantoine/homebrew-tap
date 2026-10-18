class Muxer < Formula
  desc "Connects the Muxer Android app to cmux on this Mac"
  homepage "https://github.com/gantoine/muxer"
  version "0.6.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/gantoine/muxer/releases/download/0.6.0/muxer-0.6.0-darwin-arm64.tar.gz"
    sha256 "415f385b225c2619c58423550b7e89bde193c84059196991769f1c0167bd6dad"
  else
    url "https://github.com/gantoine/muxer/releases/download/0.6.0/muxer-0.6.0-darwin-amd64.tar.gz"
    sha256 "0bc23f3dd84e6cb8c790c3bbfebf5f7630d72c2aa6d03f35ccbea612d0fc5d8a"
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
