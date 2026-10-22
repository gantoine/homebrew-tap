class Muxer < Formula
  desc "Connects the Muxer Android app to cmux on this Mac"
  homepage "https://github.com/gantoine/muxer"
  version "0.8.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/gantoine/muxer/releases/download/0.8.0/muxer-0.8.0-darwin-arm64.tar.gz"
    sha256 "f29715ac37b5e6322daebf4cc8b2eb7b56968b795c221f9f6c177e087d060fea"
  else
    url "https://github.com/gantoine/muxer/releases/download/0.8.0/muxer-0.8.0-darwin-amd64.tar.gz"
    sha256 "8cc2519e697d95cbc9d2d2478d9256bbb385f7b2ee89de7c00f8a9b7fa83a303"
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
